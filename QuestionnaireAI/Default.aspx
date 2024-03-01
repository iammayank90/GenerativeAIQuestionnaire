<%@ Page Title="Home Page" Language="C#" AutoEventWireup="true"
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@picocss/pico@1/css/pico.min.css">

    <style>
        :root {
            --primary-color: #4a67ff;
            --secondary-color: #f0f0f0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #da898c;
            background-image: linear-gradient(147deg, #da898c 0%, #59090c 74%);
        }

        nav {
            background-color: #dc2323;
            color: white;
            margin-bottom: 2rem;
        }

            nav ul {
                display: flex;
                justify-content: space-between;
                list-style-type: none;
                padding: 0;
            }

                nav ul li strong,
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
            max-width: 960px;
            margin: auto;
            padding: 2rem;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .container-fluid {
            width: 63%;
            margin-right: 282px;
            margin-left: auto;
            padding-right: var(--spacing);
            padding-left: var(--spacing);
            height: 52px;
        }

        button {
            background-color: hsl(205 25% 57% / 1);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

            button:hover {
                background-color: hsl(205deg 33.19% 73.83%);
            }

        #queryForm {
            display: grid;
            grid-template-columns: 1fr auto auto;
            gap: 10px;
        }

        #queryList li {
            background-color: var(--secondary-color);
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
        }

        #list-container {
            font-family: Arial, sans-serif;
        }

        #filter-input {
            margin-bottom: 20px;
            width: calc(100% - 20px); /* Adjust input width to account for padding */
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box; /* Ensures padding is included in the width */
        }

        ul {
            list-style: none;
            padding: 0;
            margin: 0;
            border: 1px solid #eee;
            border-radius: 5px;
        }

            ul li {
                padding: 10px;
                border-bottom: 1px solid #eee;
                transition: background-color 0.3s;
            }

                ul li:last-child {
                    border-bottom: none;
                }

                ul li:hover {
                    background-color: #f0f0f0;
                }

        .image-dil {
            margin-bottom: -75px !important;
            margin-left: 50px !important;
        }

        .quest {
            margin-left: 16px;
            margin-top: 9px;
        }

        .home {
            margin-right: 16px;
            margin-top: 0px;
            color: hsl(0deg 0% 100%);

        }
    </style>

</head>
<body>
    <a href="/">
        <img class="image-dil" alt="Diligent" loading="lazy" width="157" height="44" decoding="async" data-nimg="1" class="mr-8" style="color: transparent" srcset="https://www.diligent.com/_next/image?url=%2Flogo%2Fdiligent_logo_fullcolor_rgb.svg&amp;w=256&amp;q=75 1x, https://www.diligent.com/_next/image?url=%2Flogo%2Fdiligent_logo_fullcolor_rgb.svg&amp;w=384&amp;q=75 2x" src="/_next/image?url=%2Flogo%2Fdiligent_logo_fullcolor_rgb.svg&amp;w=384&amp;q=75">
    </a>
    <nav class="container-fluid">
        <strong class="quest">QuestionnaireAI</strong>
        <a class="home" href="#"> <strong>Home</strong></a>
    </nav>
    <main class="container">
        <div class="grid">
            <section>
                <hgroup>
                    <h2>Enter Your Queries</h2>
                    <h3>QuestionnaireAI is an AI tool for creating and analyzing questionnaires, enhancing data collection and analysis.</h3>
                </hgroup>
                <p>Manage and export responses with ease to import in Forms and workflow.</p>
                <form id="queryForm" class="grid">
                    <input type="text" id="queryInput" name="queryInput" placeholder="Enter vendor's bussiness type" aria-label="Query input" required />
                    <button type="button" onclick="createquestions()">Submit</button>
                    <button type="button" onclick="clearFields()">Clear</button>
                </form>
                <section aria-label="Query Results">
                    <h2>Results</h2>
                    <div id="list-container">
                        <input type="text" id="filter-input" placeholder="Filter items..." style="display: none">
                        <ul id="dynamic-list"></ul>
                    </div>
                </section>
                <div id="exportsec" style="display: none">
                    <p>Export the AI generated responses to PDF</p>
                    <button type="button" onclick="exportquest()" class="export-button" style="width: auto;">Export Response to PDF</button>
                    <p>Choose MRQ or DDQ templates to add the AI generated responses</p>
                    <input type="file" id="upload" accept=".xlsx, .xls" />
                    <button type="button" id="addRows" style="display: none">Add Answers to Excel & Download</button>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script>
                </div>
            </section>
        </div>
    </main>
</body>
</html>

