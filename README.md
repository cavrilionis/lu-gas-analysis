# NoteGuessR

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE) 
[![ShinyApps.io](https://img.shields.io/badge/shinyapps.io-deployed-brightgreen.svg)](https://christos.shinyapps.io/noteguessr/)

This repository contains the code for the [NoteGuessR](https://christos.shinyapps.io/noteguessr/) web application, a tool designed to help musicians practice note recognition in the bass clef.

**What is NoteGuessR?**

NoteGuessR is a simple yet effective web app that generates random notes within the E2 to G4 range on a standard bass clef staff. Your mission? To accurately identify each note as quickly as possible. It's perfect for:

* **Beginner musicians:** Solidify your understanding of bass clef notation.
* **Students:** Supplement your music theory practice.
* **Anyone looking for a quick musical brain teaser!**

**Features:**

* **Random Note Generation:** Notes are randomly selected within the E2 to G4 range, ensuring a varied practice session.
* **Bass Clef Focus:** Specifically designed for bass clef practice.
* **Interactive Interface:** User-friendly experience for effortless learning.
* **Deployed on ShinyApps.io:** Accessible directly through your web browser. ([https://christos.shinyapps.io/noteguessr/](https://christos.shinyapps.io/noteguessr/))

**How to Use (Online):**

1.  Visit the deployed application: [https://christos.shinyapps.io/noteguessr/](https://christos.shinyapps.io/noteguessr/)
2.  Use the slider to select how many notes to guess.
3.  A random note will appear on the staff.
4.  Click the corresponding note name and submit your guess.
5.  See if you are correct!
6.  When the game is over, click the "Restart" button for another challenge.

**Running Locally (For Developers):**

If you'd like to run NoteGuessR locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/cavrilionis/noteguessr.git](https://www.google.com/search?q=https://github.com/cavrilionis/noteguessr.git)
    cd noteguessr
    ```
2.  **Install R and necessary packages:**
    * Ensure you have R installed on your system.
    * Open R and install the required packages:
        ```R
        install.packages(c("shiny"))
        ```
3.  **Run the application:**
    ```R
    shiny::runApp()
    ```
4.  The app will open in your default web browser.

**Contributing:**

Contributions are welcome! If you have suggestions for improvements, bug fixes, or new features, please:

1.  Fork the repository.
2.  Create a new branch for your feature or fix.
3.  Submit a pull request.

**License:**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

**Author:**

* [cavrilionis](https://github.com/cavrilionis)

**Acknowledgments:**

* Thanks to the Shiny team for creating such a powerful framework.

**Future Enhancements:**

* [ ] Treble clef support.
* [ ] Timer/score tracking.
* [ ] Customizable note ranges.
* [ ] More interactive feedback.
* [ ] Mobile responsiveness.

**Let's get practicing!** 🎶
