DROP DATABASE IF EXISTS ABCSTUDIOS ;
CREATE DATABASE ABCSTUDIOS CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE ABCSTUDIOS;

CREATE TABLE Curso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW()
);

CREATE TABLE Administrador (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    email VARCHAR(256) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    CONSTRAINT TB_Administrador_email_U UNIQUE (email)
);

CREATE TABLE Professor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    email VARCHAR(256) UNIQUE NOT NULL,
    password TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    ultimo_login DATETIME DEFAULT NOW() NOT NULL,
    CONSTRAINT TB_Professor_email_U UNIQUE (email)
);

CREATE TABLE ProfessorContacto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    link TEXT NOT NULL,
    id_professor INT NOT NULL,
    CONSTRAINT TB_ProfessorContacto_Professor_FK FOREIGN KEY (id_professor) REFERENCES Professor(id) ON DELETE CASCADE
);

CREATE TABLE Disciplina (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW()
);

CREATE TABLE Curso_Disciplina (
    idCurso INT,
    idDisciplina INT,
    CONSTRAINT TB_CursoDisciplina_PKs PRIMARY KEY (idCurso, idDisciplina),
    CONSTRAINT TB_CursoDisciplina_Curso_FK FOREIGN KEY (idCurso) REFERENCES Curso(id) ON DELETE CASCADE,
    CONSTRAINT TB_CursoDisciplina_Disciplina_FK FOREIGN KEY (idDisciplina) REFERENCES Disciplina(id) ON DELETE CASCADE
);

CREATE TABLE Disciplina_Professor (
    idDisciplina INT,
    idProfessor INT,
    CONSTRAINT TB_DisciplinaProfessor_PKs PRIMARY KEY (idDisciplina, idProfessor),
    CONSTRAINT TB_DisciplinaProfessor_Disciplina_FK FOREIGN KEY (idDisciplina) REFERENCES Disciplina(id) ON DELETE CASCADE,
    CONSTRAINT TB_DisciplinaProfessor_Professor_FK FOREIGN KEY (idProfessor) REFERENCES Professor(id) ON DELETE CASCADE
);

CREATE TABLE AnoLetivo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Turma (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    idCurso INT NOT NULL,
    idAnoLetivo INT NOT NULL,
    CONSTRAINT TB_Turma_Curso_FK FOREIGN KEY (idCurso) REFERENCES Curso(id) ON DELETE CASCADE,
    CONSTRAINT TB_Turma_Anoletivo_FK FOREIGN KEY (idAnoLetivo) REFERENCES AnoLetivo(id) ON DELETE CASCADE
);

CREATE TABLE Aluno (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    email VARCHAR(256) NOT NULL,
    idTurma INT NOT NULL,
    password TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    ultimo_login DATETIME DEFAULT NOW() NOT NULL,
    CONSTRAINT TB_Aluno_Turma_FK FOREIGN KEY (idTurma) REFERENCES Turma(id) ON DELETE CASCADE,
    CONSTRAINT TB_Aluno_email_U UNIQUE (email)
);

CREATE TABLE AlunoContacto (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    link TEXT NOT NULL,
    id_aluno INT NOT NULL,
    CONSTRAINT TB_AlunoContacto_Aluno_FK FOREIGN KEY (id_aluno) REFERENCES Aluno(id) ON DELETE CASCADE
);

CREATE TABLE Divisor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    idTurma INT NOT NULL,
    idDisciplina INT NOT NULL,
    CONSTRAINT TB_Divisor_Turma_FK FOREIGN KEY (idTurma) REFERENCES Turma(id) ON DELETE CASCADE,
    CONSTRAINT TB_Divisor_Disciplina_FK FOREIGN KEY (idDisciplina) REFERENCES Disciplina(id) ON DELETE CASCADE
);

CREATE TABLE Ficheiro (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    codigo TEXT NOT NULL /* ID COMO O FICHEIRO É GUARDADO */,
    ordem INT NOT NULL,
    e_visivel BOOLEAN DEFAULT TRUE NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    idDivisor INT NOT NULL,
    CONSTRAINT TB_Ficheiro_Divisor_FK FOREIGN KEY (idDivisor) REFERENCES Divisor(id) ON DELETE CASCADE
);

CREATE TABLE Submissao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    data_fim DATETIME NOT NULL,
    idDivisor INT NOT NULL,
    CONSTRAINT TB_Submissao_Divisor_FK FOREIGN KEY (idDivisor) REFERENCES Divisor(id) ON DELETE CASCADE
);

CREATE TABLE FicheiroSubmetido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL,
    codigo TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    idSubmissao INT NOT NULL,
    CONSTRAINT TB_FicheiroSubmetido_Submissao_FK FOREIGN KEY (idSubmissao) REFERENCES Submissao(id) ON DELETE CASCADE
);

CREATE TABLE Notificacao (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    idTurma INT NOT NULL,
    idDisciplina INT NOT NULL,
    idProfessor INT NOT NULL,
    CONSTRAINT TB_Notificacao_Turma_FK FOREIGN KEY (idTurma) REFERENCES Turma(id) ON DELETE CASCADE,
    CONSTRAINT TB_Notificacao_Disciplina_FK FOREIGN KEY (idDisciplina) REFERENCES Disciplina(id) ON DELETE CASCADE,
    CONSTRAINT TB_Notificacao_Professor_FK FOREIGN KEY (idProfessor) REFERENCES Professor(id) ON DELETE CASCADE
);

CREATE TABLE TipoCompromisso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome TEXT NOT NULL
);

CREATE TABLE Compromisso (
    id INT PRIMARY KEY AUTO_INCREMENT,
    descricao TEXT NOT NULL,
    data DATETIME NOT NULL,
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    idTipo INT NOT NULL,
    idProfessor INT NOT NULL,
    idDisciplina INT NOT NULL,
    idTurma INT NOT NULL,
    CONSTRAINT TB_Compromisso_TipoCompromisso_FK FOREIGN KEY (idTipo) REFERENCES TipoCompromisso(id) ON DELETE CASCADE,
    CONSTRAINT TB_Compromisso_Professor_FK FOREIGN KEY (idProfessor) REFERENCES Professor(id) ON DELETE CASCADE,
    CONSTRAINT TB_Compromisso_Disciplina_FK FOREIGN KEY (idDisciplina) REFERENCES Disciplina(id) ON DELETE CASCADE,
    CONSTRAINT TB_Compromisso_Turma_FK FOREIGN KEY (idTurma) REFERENCES Turma(id) ON DELETE CASCADE
);

CREATE TABLE Codigo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(10) NOT NULL, /* ID, Codigo em si */
    data_criacao DATETIME DEFAULT NOW() NOT NULL,
    data_fim DATETIME DEFAULT NULL,
    idProfessor INT NOT NULL,
    idDisciplina INT NOT NULL,
    idTurma INT NOT NULL,
    CONSTRAINT TB_Codigo_Professor_FK FOREIGN KEY (idProfessor) REFERENCES Professor(id) ON DELETE CASCADE,
    CONSTRAINT TB_Codigo_Disciplina_FK FOREIGN KEY (idDisciplina) REFERENCES Disciplina(id) ON DELETE CASCADE,
    CONSTRAINT TB_Codigo_Turma_FK FOREIGN KEY (idTurma) REFERENCES Turma(id) ON DELETE CASCADE
);

CREATE TABLE Codigo_Aluno (
    idCodigo INT,
    idAluno INT,
    data_presenca DATETIME DEFAULT NOW() NOT NULL,
    CONSTRAINT TB_CodigoAluno_PKs PRIMARY KEY (idCodigo, idAluno),
    CONSTRAINT TB_CodigoAluno_Codigo_FK FOREIGN KEY (idCodigo) REFERENCES Codigo(id) ON DELETE CASCADE,
    CONSTRAINT TB_CodigoAluno_Aluno_FK FOREIGN KEY (idAluno) REFERENCES Aluno(id) ON DELETE CASCADE
);



/* INSERTS */
INSERT INTO AnoLetivo VALUES (1,'19/20'), (2, '20/21'), (3, '21/22');

INSERT INTO Curso (id, nome) VALUES 
    (1, 'Engenharia Informática'), (2, 'Engenharia Industrial'), (3, 'Tecnologias da Informação e Multimédia');
INSERT INTO Disciplina (id, nome) VALUES
    (1, 'Programação 1'), (2, 'Probabilidades e Estatística'), (3, 'Álgebra Linear e Geometria Analítica'), 
     (4, 'Inglês Técnico I'), (5, 'Matemática para a Informática I'), (6, 'Sistemas Lógicos');
INSERT INTO Curso_Disciplina VALUES (1,1), (1,2), (1,3), (1,4), (1,5), (1,6);

INSERT INTO Disciplina (id, nome) VALUES
    (7, 'Desenho Técnico'), (8, 'Fundamentos de Termodinâmica'), (9, 'Fundamentos de Matemática'),
     (10, 'Electrotécnia e Instalações Eléctricas'), (11, 'Programação de Computadores');
INSERT INTO Curso_Disciplina VALUES (2,7), (2,8), (2,3), (2,4), (2,9), (2,10), (2,11);

INSERT INTO Disciplina (id, nome) VALUES
    (12, 'Interfaces Pessoa-Máquina I'), (13, 'Lógica'), (14, 'Multimédia I');
INSERT INTO Curso_Disciplina VALUES (3,1), (3,4), (3,2), (3,13), (3,14);

INSERT INTO Turma (id, idCurso, idAnoLetivo) VALUES
    (1,1,2), (2,2,2), (3,3,2), (4,1,3), (5,2,3), (6,3,3);