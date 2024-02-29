<%@ Page Title="Home Page" Language="C#" MasterPageFile="" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="QuestionnaireAI._Default" %>

    <!DOCTYPE html>
<html lang="en">
    <head>
  <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- Include external JavaScript file -->
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
        <script src="Scripts/Custom/QuestionHelper.js"></script>
        <link href="Style/pico.css" rel="stylesheet" />
   
         <style>
        :root {
            --primary-color: #4a67ff;
            --secondary-color: #f0f0f0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        nav {
            background-color: var(--primary-color);
            color: white;
        }

            nav ul li a {
                color: white;
                text-decoration: none;
            }

                nav ul li a:hover,
                nav ul li a:focus {
                    text-decoration: underline;
                }

        main {
            padding-top: 2rem;
        }

        .container {
            max-width: 800px;
            margin: auto;
        }

        #queryForm button,
        .export-button {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

            #queryForm button:hover,
            .export-button:hover {
                background-color: darken(var(--primary-color), 10%);
            }

        #queryList li {
            background-color: var(--secondary-color);
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
        }
    </style>

</head>
    <body>
    <form id="form1">
        <nav class="container-fluid">
        <ul>
            <li><strong>QuestionnaireAI</strong></li>
        </ul>
        <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#">Features</a></li>
            <li><a href="#" role="button">Contact</a></li>
        </ul>
    </nav>
    <main class="container">
        <div class="grid">
            <section>
                <hgroup>
                    <h2>Enter Your Queries</h2>
                    <h3>Simple and Efficient</h3>
                </hgroup>
                <p>Use the form below to submit your queries. Manage and export responses with ease.</p>
                <form id="queryForm" class="grid">
                    <input type="text" id="queryInput" name="queryInput" placeholder="Your query..." aria-label="Query input" required />
                    <button type="button" onclick="createquestions()">Submit</button>
                    <button type="button" onclick="clearFields()">Clear</button>
                </form>
                <section aria-label="Query Results">
                    <h2>Results</h2>
                    <ul id="queryList"></ul>
                    <button type="button" onclick="exportquest()" class="export-button">Export</button>
                </section>
            </section>
        </div>
    </main>
    <footer class="container">
        <small><a href="#">Privacy Policy</a> • <a href="#">Terms of Use</a></small>
    </footer>
    </form>
</body>
    </html>

