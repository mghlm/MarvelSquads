# Marvel Squads



*_Marvel Squads let's you see all character from the Marvel universe in a list. You can select any one of them to go to a screen with more details, as well as save them to a dedicated space - your "squad" - in the app ._*



### Approach taken

The app is built using MVVM-C architecture, where the ViewModel for each screen is responsible for the business logic (such as communicating with the networking and storage layers) and coordinators are used for navigation. The ViewControllers have been kept simple and are only responsible for presenting UI. 

The app persist the the selected characters and their related image data in a Core Data database, and will present the stored data if user is offline. 

Business logic is tested with unit testing, and UI is tested with XCUI UI testing. 

The app is built using a protocol oriented approach and with scalability in mind.



### Technologies used


-  [Swift 5](https://developer.apple.com/swift/)

- [The Marvel API](https://developer.marvel.com)


### How to test it

To test the app simply clone the repo, and build in latest version of Xcode. No need to run any third party library package managers. 

### Known issues

- Loading spinners missing for Comics section in details view
- Character model is not NSManagedObject, so when saving a character, instead of saving the actual character, a new "SquadMember" object is created. Due to time constraints I haven't fixed this design flaw, but it is something I would have done different if I were to build a similar app again; basically designing with CoreData in mind from the beginning. 

### Future Improvements / Additions

- Implement a search function 
- A way to navigate to comics details and see more related comics
- Setup dedicated UI Testing environment with separate database etc. 



### Screenshots



![alt text](https://i.imgur.com/8jFGWUx.png)



### User stories:



```

As a user I can see all characters from the Marvel universe in a list

```

```

As a user I can see details about a selected character, such as description and related comics, in a new screen 

```
```

As a user I can add a character to my "Squad" 

```
```

As a user I can remove a character from my "Squad" 

```

```

As a user, I can see my "Squad" in a header view on the home screen 

```
```

As a user, if I'm offline, I can still see my selected characters in my "Squad"

```
