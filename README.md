# SpacePics

A Flutter app that shows today's and past pictures from NASA's "Astronomy Picture of the Day".

## Requirements

Requirements defined by CloudWalk:

- Have two screens: a list of the images and a detail screen
- The images list must display the title, date and provide a search field in the top (find by title or date)
- The detail screen must have the image and the texts: date, title and explanation
- Must work offline (will be tested with airplane mode)
- Must support multiple resolutions and sizes

## Usage

Once the app loads it presents you with a list of Pictures of the Day from Nasa, starting on the current day and going back 30 days*. 

![Home Screen](/documents/screenshots/home.png) 

There are two search options available. One by date (YYYY-MM-DD) or by keyword. The keyword option let's you search by titles**. You may tap on any picture to see its details such as an enlarged picture and its explanation. 

![Search by Date](/documents/screenshots/search_by_date.png) | ![Detail Screen](/documents/screenshots/img_detail.png)

To search by title type a keywork and press 'go' on your keyboard.

![Search by Keyword](/documents/screenshots/search_by_keyword.png)

The app also gives you an option to see pictures when offline. Both pictures and data are stored locally and range from 2022-06-01 to 2022-08-18.

![Offline Mode](/documents/screenshots/home_offline.png)

You may also search in offline mode either by date (limited to the date range mentioned above) or by keyword. 

![Offline Search](/documents/screenshots/search_offline.png)

*Note: Sadly some of the pictures have codec issues which makes them unavailable on the app. 
**Since searching by title is not easily accesible through NASA's API, the app gives you access to their data (locally) from 2020-01-01 to 2022-08-18.

## Technologies

- Flutter 3.0.0
- Dart 2.17.0

For dependencies please check the pubspeck.yaml file.

## Running It

This app has been developed with a focus on iOS. This means it has not been tested on Android devices. With that in mind, you should run it on mac computer with a Simulator installed. To run the app locally you must first clone the repository, and with the Simulator open and loaded, inside the repository directory run the following command in your terminal:

```
flutter run
```

## Testing

To run all tests, inside of the repository directory, type the following command in your terminal:

```
flutter test
```

## Future Improvements

- Increase testing coverage
- Improve UI and UX




