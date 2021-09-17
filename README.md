# QR Attendance app

This is the flutter application for the QR Attendance app. The app allows teachers to generate a dynamic QR based on the details of a class and the students to scan it to confirm their attendance.

File structure
- assets - contains static images used in the project
- lib - contains code for different pages on the app

Files-
- `homepage.dart` - homepage which contains form for logging in as a student or teacher
- `login_admin.dart` - logic for logging in as a teacher 
- `login_student.dart` - logic for logging in as a student
- `classdetails.dart` - Displays the class details as entered by the teacher
- `generate.dart` - Generates and displays QR based on class details
- `scan.dart` - Allows scanning of the QR code and creates a request at the server for marking attendance
- `attendance.dart` - Allows students to check their attendance

### NOTE:
This repo is only the frontend of the app. Therefore it contains phrases like `SERVER ENDPOINT` which are aliases to the original API. This application cannot be run as a standalone flutter app. To get access to the server, please contact the contributors of this project.


Video demoes:
- [Teacher view](https://drive.google.com/file/d/17H8-fRWq68B2SRs3XKslGKJgzIgY7PMK/view?usp=sharing)
- [Student View](https://drive.google.com/file/d/1JGjegN8_i_Oz10a1MTWeh-sZ2jhPUnvb/view?usp=sharing)
