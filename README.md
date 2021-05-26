# SwanCodingChallenge

Swan Weather App Flow

Code Setup & Version
App is using cocoapods
Please navigate to Project directory in console and type “pod install”
Pods will be installed and you are ready to run the App
Swift 5 is used.
Minimum iOS version 11.0
Xcode Version 12.5
Storyboard is used.
If you have any problems while setting up please feel free to contact me back.

Landing Page(WeatherForcastViewController)

App starts and on the landing page it asks for Location Permission, if the user allows location we gonna get current lat long and call the five days weather report from OpenWeather API.
We parse and filter the data, i didn’t parse extra values that were not required in our UI.
Temp gets converted to celsius and time to formatted time, images are showing as per weather e.g Cloudy, Clear
On top search bar users can tap and it will navigate to the Search/Current Weather Screen
I had an option to perform a search on this page and when data gets saved navigate to the next screen but after reading this “On tap takes the user to the next screen” on clicking on search i am taking the user to search/current weather screen.

Search (CurrentWeatherViewController)

On the Search screen, users can see 5 recent searches in the Recent Searches Section.
If no search yet made only header will show with Recent Searches title
When the user will click on the search bar and type something which has more than 1 character and click on the search button the text will be saved to RealmDB and it’s recent searches will be updated.
 User can see current weather as per current location while he clicks on the search button or taps on recent searches.
An activity indicator will appear until we have user current location weather report from OpenWeather API

Other Details

We have a network class that controls everything related to network calls.
LocationManager is used for all types of location related stuff.
I have also added validation like internet connectivity and location permission checks.
I tried to show a few options to do the same thing e.g Activity indicator on search screen and a label on landing screen to show user on going activity.





