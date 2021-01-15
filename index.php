<?php
    include("./php/funcoes.php");
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/hiddenContent.js"></script>

    <title>Document</title>
</head>
<body>
    <?php
        include("navbar.php");
    ?>
    <div class="mainContainer">
        <div class="diasSemana">
            <div class="dia">
                <p>Segunda</p>
            </div>
            <div class="dia">
                <p>Terça</p>
            </div>
            <div class="dia">
                <p>Quarta</p>
            </div>
            <div class="dia">
                <p>Quinta</p>
            </div>
            <div class="dia">
                <p>Sexta</p>
            </div>
            <div class="dia">
                <p>Sabado</p>
            </div>
            <div class="dia">
                <p>Domingo</p>
            </div>
        </div>
        <div class="content">
            <div class="disciplinasContainer">
                <div class="disciplina">
                    <p>Disciplina1</p>
                </div>
                <div class="disciplina">
                    <p>Disciplina2</p>
                </div>
                <div class="disciplina">
                    <p>Disciplina3</p>
                </div>
                <div class="disciplina">
                    <p>Disciplina4</p>
                </div>
                <div class="disciplina">
                    <p>Disciplina5</p>
                </div>
                
            </div>
            
            <div class="infoContainer">
                <div class="compromissosContainer">
                    <div class="compromissosRow">
                        <div class="compromissosData">
                            21/10/2020
                        </div>
                        <div class="compromissosBox">
                            Apresentação de Base de Dados
                        </div>
                    </div>
                    <div class="compromissosRow">
                        <div class="compromissosData">
                            21/10/2020
                        </div>
                        <div class="compromissosBox">
                            Apresentação de Base de Dados
                        </div>
                    </div>
                </div>
                <div class="notificacoesContainer">
                    <div class="notificacoesRow">
                        <div class="notificacoesName">
                            Prof.Carlos
                        </div>
                        <div class="notificacoesBox">
                            Peço a todos os alunos......
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>