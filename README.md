# News Application

![featured](https://github.com/Imen-ks/NewsApp/blob/main/NewsApp/Assets.xcassets/News.png)

Xcode project relating to an iOS application using the [NewsCatcher API](https://newscatcherapi.com/) to display multi-language worldwide news articles published online.

## Usage

Request for an API key by creating an account on the Newscatcher API website.  
Open the `NewsApp.xcodeproj` file with Xcode, add a `.config` file containing the following line: `X_API_KEY = <YOUR_API_KEY>`  
Build the application in the simulator or on a device.

## API endpoints used in the app

- `/search` : enables to filter out articles based on keywords, publish date, language, country
- `/latest_headlines` : displays the latest articles based on their topic, country, sources, language
- `/sources` : returns a list of the top 100 supported news websites
