# NFe XML Converter

## Overview

The NFe XML Converter is a Rails application designed to convert NFe keys into XML files, organize them by customer and date, and provide a downloadable `.tar.gz` archive containing the XML files.

## Features

- Input multiple NFe keys.
- Specify a customer name.
- Generate XML files for each NFe key.
- Organize XML files by customer and date.
- Download a `.tar.gz` archive containing the XML files.

## Installation

1. Clone the repository:

    ```sh
    git clone https://github.com/yourusername/nfe_xml_converter.git
    cd nfe_xml_converter
    ```

2. Install dependencies:

    ```sh
    bundle install
    ```

3. Set up the database (if applicable):

    ```sh
    rails db:create
    rails db:migrate
    ```

4. Start the Rails server:

    ```sh
    rails server
    ```

## Usage

1. Open your web browser and navigate to `http://localhost:3000/api/v1/xml_converter/new`.

2. You will see a form with the following fields:
    - **Chaves de acesso da NFe (um por linha)**: Enter the NFe keys, one per line.
    - **Cliente**: Enter the customer name.

3. Click the "Converter" button to submit the form.

4. The application will process the NFe keys and generate XML files for each key. The XML files will be organized by customer and date.

5. You will be redirected to a page where you can download the `.tar.gz` archive containing the XML files. You can also access each XML file individually.
