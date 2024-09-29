# HummingbirdExample
Example demonstrating how to send an email using [IndiePitcher](https://indiepitcher.com) from a Hummingbird backend.

- Create a free account at https://indiepitcher.com
- Create a new project
- Create an API key for your project
- create `.env` file
- Add `INDIEPITCHER_SECRET_KEY=yourapikey`
- Open `Application+build.swift` and optionally update the email to your email address
- Launch the project (Xcode, VSCode, `swift run`)
- launch `curl -v 127.0.0.1:8080/send_email`
