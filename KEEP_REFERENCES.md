### My thoughts on how I would go about keeping the asset references up to date.

When an asset reference is no longer valid, it's probably because:

- The asset was removed from the application (like a .js or .css that is not needed anymore and is removed from the CDN), so it won't be found.

- The asset was updated and the file is renamed (like asset digest in rails) but the old file is not removed from the CDN. This old file will never be requested by the user again because it's not referenced in the application html, so it will not be cached even if the new one do.

My approach to solve this issue would be to create a mechanism to periodically check if both the asset exists and it's referenced in the application html.

To implement this mechanism, I would create a task to request the assets saved in the database, using Faraday (https://github.com/lostisland/faraday) or HTTParty (https://github.com/jnunemaker/httparty), in order to check if the assets still exists. After that, the task would read the application html source, maybe using Nokogiri (http://www.nokogiri.org),  to check if it's still referenced. In case the asset doesn't exist anymore or is not referenced in the application html, the task sends a notification via e-mail to a member of the team.

To make it run periodically I would use Sidekiq (http://sidekiq.org/) to schedule the task to run automatically as many times as it's needed a day (would discuss this with the team).

This way, we would have a tool to make the job of checking if the assets references exists for us.
