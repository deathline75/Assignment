# Assignment
This repository is for EAD.

We use Eclipse as our IDE.

The reason why we did not use Maven as our lecturers probably don't allow it. :(

## Usage
1. Clone this repository in your local machine.
2. Open up your Eclipse workspace and press File > Import > General > Existing Files from Workspace
3. Navigate to and select your cloned workspace.
4. Let Eclipse do its thing.
5. Import Gson into your workspace via right clicking your Project > Properties
6. In the left pane, click Java Build Path then go to the Libraries tab. Add your Gson jar here (internal or external).
7. Go to Deployment Assembly on the left pane and click Add.
8. Click Java Build Path Entries and click Next and Finish.
9. Close your Properties window.
10. Navigate to Assignment > Java Resources > src > com.ice and create a new class MyConstants.java
11. Add this line in your class and replace the value to your own secret reCaptcha key:
```java
	public static final String SECRET_KEY = "Insert Your reCaptcha secret key here.";
```
12. You are done.

## Dependencies
- [Gson](http://search.maven.org/#artifactdetails%7Ccom.google.code.gson%7Cgson%7C2.6.2%7C)

