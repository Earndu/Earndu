

# What is Earndu?

 We developed 'Earndu' in the hope that equal education will be achieved and that intellectuals will earn the right return through their knowledge.

<br/>
<br/>
### playstore

https://play.google.com/store/apps/details?id=com.dscsch.earndu

### Youtube


[![Earndu - GDSC Solution Challenge 2021
](http://img.youtube.com/vi/jNA1yJRN4_g/0.jpg)](https://youtu.be/jNA1yJRN4_g)

>If you want to see video, Click the image.

<br/>
<br/>


### Object

- Our main goal is to minimize poverty issues by providing quality education to a large number of students who struggle from inequality. The solution endeavors to provide partnerships to achieve those goals.
- Our strategy is to utilize minimal network and to provide limited types of contents.
- Education gap exists due to unfair infrastructure, thus we attempted to narrow the gap by utilizing technology. Considering the needs of the disabled, we enabled to deliver all information by providing limited types of contents.

<br/>
<br/>

### Logic

We agonized to provide educational content even in situations where the network is not working well. When attempting to log in, the currently existing wish list is transmitted to JSON, and the user downloads contents. Simultaneously, the user receives the contents list. This allowed us to sufficiently communicate with minimal network traffic, by providing and receiving the recorded contents that are operated inside the application.


<br/>
<br/>

### Features

* relatively, Earndu is free from the 🌎internet .
* There is a variety of contents that can be used freely by any student.👍
* Download the content you want and take 📔 anytime, anywhere.
* you can check your growth 💪 by learning every day.


<br/>
<br/>

### ✏️ Student app (Playstore : "Earndu")
| ![image](https://user-images.githubusercontent.com/59018852/113182389-ce0dff80-928d-11eb-805f-365455bcb565.png) | ![image](https://user-images.githubusercontent.com/59018852/113182491-ebdb6480-928d-11eb-8e39-ce943b443cb0.png) | ![image](https://user-images.githubusercontent.com/59018852/113182556-fe559e00-928d-11eb-91b3-37e727d625e6.png) |
|---|:---:|---:|
| ![image](https://user-images.githubusercontent.com/59018852/113182711-2e04a600-928e-11eb-8fdb-17989142186c.png) | ![image](https://user-images.githubusercontent.com/59018852/113182663-1f1df380-928e-11eb-8120-b8f0c11126d3.png) | ![image](https://user-images.githubusercontent.com/59018852/113182616-0e6d7d80-928e-11eb-9518-b1f66b4e78f6.png) |

<br/>

### ✏️ Teacher app (Playstore : "Earndu-Teacher")
| ![image](https://user-images.githubusercontent.com/59018852/113183153-abc8b180-928e-11eb-846a-61779c20f6f0.png) | ![image](https://user-images.githubusercontent.com/59018852/113183235-c13ddb80-928e-11eb-84d6-9b6d727d9a47.png) | ![image](https://user-images.githubusercontent.com/59018852/113183299-cf8bf780-928e-11eb-8275-63b7d5c09039.png) |
|---|:---:|---:|

<br/>

### ✏️ Teacher web
http://svclaw.ipdisk.co.kr:11002/content/add

<br/>
<br/>


### Build and run

you should have `flutter`, `android studio(emulator)`


- `Fork` this repository and `clone` to local.
- Launch `Terminal` and move to StudentApp.
- Please type `flutter pub get` before running.
- Click `run` or `debug` button on your editor.
- select your `emulator` and build this app.

<br/><br/>


### Tech
- Backend : Django was used to build the web and DB simultaneously.
- Frontend: Flutter was used to produce APPs that can be executed by Android and iOS at once.
- Transfer(HTTP/S, JSON) : It is realized to communicate via HTTP/S by putting the user's request in JSON at once.
- SHA-256 : Security was enhanced by encrypting the user's password with HASH.

>**Google technology** : flutter : Dart 2.10.5 / Flutter 1.22.6
>**another technology** : Android, Django, Swift, http, https, JSON, mysql


<br/><br/>

### Used package
- cupertino_icons: ^1.0.0
- flutter_swiper: ^1.1.6
- http: ^0.12.0
- auto_size_text: ^2.1.0
- fl_chart: ^0.12.3
- share:
- intl:
- cupertino_date_textbox:
- modal_bottom_sheet: ^1.0.0+1
- #shared_preferences: ^0.5.12+4
- assets_audio_player: ^2.0.15
- flutter_markdown: ^0.5.2

<br/>
<br/>

### Feedback

- The home menu button composition is complicated to use for people who are visually impaired, so it needs to be modified.
- Users hope to see horizontally when they see contents with pictures only.
- It is advantageous because users are able to learn although their visual and auditory sense does not function well, because the contents are limited to writing letter, pictures, and voice.


<br/>
<br/>


### Future / Next steps

- Currently, technology was implemented by http and https, but we are aiming to make communication better in remote regions by implementing p2p.
- We want users to be able to spot the range of improvement in one's grade, by solving quizzes after learning contents.
- If enough data is collected during No.2, we would find good content creators with TensorFlow and we would try to make them collaborate with other educational institutions.
- We hope Google AdSense works in offline settings, too. Then, we think it will be a sustainable program that will enable content creators to make money.

<br/>
<br/>

### Collaborator


|Github_Link|Name|Role
|:--:|:--:|:--:|
|[<img src="https://avatars.githubusercontent.com/u/63346802?v=4" width="100">](https://github.com/Seokhwan-Kwon)|Seokhwan Kwon|Project Manager
|[<img src="https://avatars.githubusercontent.com/u/46339857?v=4" width="100">](https://github.com/svclaw2000)|KyuHwon Park|Front/Back-end
|[<img src="https://avatars.githubusercontent.com/u/59018852?v=4" width="100">](https://github.com/ingkoon)|Injae Lee | Front-end
|[<img src="https://avatars.githubusercontent.com/u/37266170?v=4" width="100">](https://github.com/junji9072)|Eunji Joo | UI/UX Designer
