# TestProjectForJob
Online store application for purchasing various products: phones, computers, clothes, etc.   
The user can login or sign up here, setup his profile. search products by the name, look through detail info on an item and log out.            
The UI was designed in accordance with the sketch in Figma. This is my pre-interview test project given me by a company.

## Technologies
- MVVM + Coordinator
- Combine (for network manager and functional bindings)
- UICollectionView Compositional Layout & Diffable DataSource
- Completely programmatically designed UI with NSLayoutConstraints
- KVO for observing properties in UserDefaults. 
- regex for validation

## Overview  
<p align="center">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/5e703761-f5ee-40ea-a990-61aff90f831d" width="180">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/2139f134-6923-4093-9ce1-aac6baa08be9" width="180">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/1d7dc8d4-24e8-447b-814a-24ce97d3456f" width="180">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/12e91af5-fe89-4bdf-9667-1070e7e30310" width="180">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/ddd622b4-a2ca-44b3-bbd5-3ae386e6528a" width="180">
</p>

______

### Auth features 
The app catches and handles 4 different errors for user's input in text fields (Signup and Login VCs). These errors are presented for a user as a red message above the text fields.  
The *regular expression* was used to validate an email address. 

<p align="center">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/635a60ca-425d-4a79-bd02-e2a7c8e8fcb2" width="200">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/14b501bd-0716-4343-bf46-72c3751fd9fb" width="200">
  <img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/7879f878-693d-4c4d-9dbc-80bc2409f0b8" width="197">
  <img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/5fdad7ef-7f71-4174-8e14-b8adcd6c0dac" width="210">

</p>

Password text field was designed with a secure eye that toggles dots and letters after tapping.  
<p align="center">
    <img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/7a5ac486-fb4c-4698-b430-7b73173033f8" width="300">
</p>

----

### Post-auth View Controllers
Main VC contains a search controller. While typing prompt table view pops up with the delay 1 second (Combine's debounce operator).   
Main VC has several sections with horizontal carousel scroll views (Compositional Layout).  
Detail VC consists of 2 collection views (the second one is for paging), detail info view and custom stepper which increments quantity and increases a price of an item.  
Profile VC provides the options of changing avatar and logging out. 

<p align="center">
  <img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/d7e6d474-3809-43e8-b526-810a412cba34" width="210">
  <img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/22f34c1f-64da-418b-a22a-fdf9026a3e9b" width="210">
<img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/5f56c206-cb4a-48cf-91bf-71e6774e5b6c" width="210">
    <img src= "https://github.com/VorkhlikArtem/TestProjectForJob/assets/115653999/427c3423-ba95-4081-83ac-ac01845a06b8" width="210">
</p>


## Requirements
- IPhone 11+
- iOS 15.0+
- XCode 13.0+

