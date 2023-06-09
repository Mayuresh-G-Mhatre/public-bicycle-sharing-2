
![Logo](/screenshots/icon.png)


# WePedL - Public Bicycle Sharing Android Application

WePedL is a Public Bicycle Sharing Android app built using flutter and firebase.
Using this app users can register with phone number, recharge wallet, scan qr code on bicycle to unlock it and rent it.




## Run Locally

Clone the project

```bash
  git clone https://github.com/shubham-indalkar/public-bicycle-sharing.git
```

Go to the project directory

```bash
  cd public-bicycle-sharing
```

Install dependencies

```bash
  flutter pub get
```

Run the application

```bash
  flutter run lib/main.dart
```


## Usage/Examples

There will be two branches:
        
    1. main - store locally using shared preferences
        ~ Use any random digits for phone number and otp to register.
        ~ Use repetitive phone number like '0000000000' or '1111111111', etc and random digits otp to login.
        ~ Use qr code samples stored in screenshots/samples for simulating lock/unlock.
        ~ Valid bicycle numbers are in range 00000 to 99999 with PEDL prefix (Eg. PEDL12345, PEDL55555, etc). 
    2. firebase - firebase integration
        ~ Work in progress


## Screenshots

![Spash Screen](/screenshots/splash_screen.gif)

<img src="screenshots/login_screen.jpg" width="358" height="681">

<img src="screenshots/otp_screen.jpg" width="358" height="681">

<img src="screenshots/registration_screen.jpg" width="358" height="681">

<img src="screenshots/home_screen.jpg" width="358" height="681">

<img src="screenshots/drawer.jpg" width="358" height="681">

![Avatar Picker](/screenshots/avatar_picker.png)


