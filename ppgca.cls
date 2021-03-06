%------------------------------------------------------------------------------

% Esta classe "ppgca" define o padr�o para disserta��es, teses e documentos
% correlatos produzidos no Programa de P�s-Gradua��o em Computa��o Aplicada
% da Universidade Tecnol�gica Federal do Paran�, em Curitiba PR.
%
% Esta classe segue o modelo da classe "book" e aceita todas as suas op��es.
% Ela tamb�m define as seguintes op��es espec�ficas:
% 
%    pdm:      Projeto de Disserta��o de Mestrado
%    msc:      Disserta��o de Mestrado
%    qualif:   qualifica��o de Doutorado
%    phd:      tese de Doutorado
%    defesa:   vers�o pr�via (s� frente, espa�amento 1.5,)
%    aprovada: vers�o final (frente/verso, espa�amento 1, p�ginas complementares)

% Os seguintes ambientes e comandos tamb�m s�o definidos:
%
% \advisor{Nome}    : define o orientador
% \coadvisor{Nome}  : define o co-orientador, se houver
% \field{�rea}      : define a �rea de concentra��o da pesquisa
% \local{Cidade}    : define o local da defesa
% \keywords{}{}...  : define tr�s palavras-chave e tr�s keywords
% \begin{resumo}    : define a p�gina de resumo
% \begin{abstract}  : define a p�gina de abstract
% \begin{agradece}  : define a p�gina de agradecimentos
% \begin{dedica}    : define a p�gina de dedicat�ria
%
% Software fornecido sob a licen�a GNU GPL. Pode ser usada e modificada
% livremente, desde que mantidas as informa��es deste cabe�alho.
%
% Hist�rico:
%
% 2007/06/01 V0.1
% - vers�o inicial, por Carlos Maziero (maziero@ppgia.pucpr.br). 
%
% 2007/06/15
% - comando \keywords
% - mais coment�rios explicativos
% - ajustes para evitar linhas �rf�s e vi�vas
%
% 2007/08/08 V0.2
% - mudei fontenc para T1, para acertar acentos no PDF
% - mudei package de "txfonts" para "times"
%
% 2007/08/08 V0.3
% - coloquei flag -tA4 no dvips (Makefile e instru��es de uso)
%
% 2007/09/02 V0.4
% - listasimb e listabrev
% - resumo, abstract e agradecimentos em negrito
%
% 2008/03/12 V0.5
% - ajustei a ordem das paginas iniciais (resumo, sum�rio, etc)
%
% 2008/06/03 V0.6
% - substitui��o do Makefile pelo script build (mais completo)
% - inclus�o da op��o "final" para gerar a vers�o final
% - estilo "apalike" para bibliografia
%
% 2008/06/11 V0.7
% - inclus�o automatica da ficha catalogr�fica, agradecimentos
%   e dedicat�ria na vers�o final do documento
% - ficha catalogr�fica no verso da segunda capa
%
% 2008/07/16 V0.8
% - removidos packages obsoletos (vide documento l2tabuen.pdf)
% - dimens�es da p�gina definidas com package "geometry"
% - espa�amento: troca de \baselinestretch por \linespread
% - indenta��o de par�grafo mudou de 12.7mm para 4em
% - trocados \bf e \sc por \textbf e \textsc
% - adotado o package setspace para espa�amento entre linhas
% - linhas do t�tulo mais espa�adas sempre, mesmo no modo "final"
% - fontes ajustados para o padr�o LaTeX2e
% - ajustada fonte default do package listings para tt footnotesize
% - retirados alguns acentos ISO deste arquivo (compatibilidade UTF8)
% - acentos \'i modificados para \'{\i}
%
% 2008/11/17 V0.9
% - op��es "draft" e "final" conflitam com op��es de documentclass, 
%   op��o "draft" vira default e op��o "final" renomeada para "aprovada"
% - corrigida ortografia errada em "Abrevia��es"
%
% 2009/06/03 V0.9.1
% - incluso exemplo de cita��o bibliogr�fica contendo URL
% - ajustes no texto do modelo Cap 1 e 2
%
% 2014/03/18 V0.9.2
% - vers�o para o PPGCA/UTFPR
% - adicionada op��o "defesa"
% - reorganiza��o do texto dos cap�tulos de exemplo
%
% Ainda por fazer:
% - numera��o das p�ginas iniciais deve ser no p� da p�gina e centralizada
% - conferir/ajustar captions de figura e tabela
% - numera��o de equa��es?
% - automatizar gera��o da ficha catalogr�fica

%------------------------------------------------------------------------------

% defini��o da classe
\ProvidesClass{ppgca}[2014/03/18 V0.9.2 (Carlos Maziero)]

%------------------------------------------------------------------------------

% op��es desta classe

% o contador doctype define o tipo de documento
\newcounter{doctype}
\setcounter{doctype}{0}

% o contador docversion define a vers�o do documento
\newcounter{docversion}
\setcounter{docversion}{0} % default � uma vers�o pr�-defesa

% pdm: projeto de disserta��o de mestrado
\DeclareOption{pdm}{\setcounter{doctype}{1}}

% msc: disserta��o de mestrado
\DeclareOption{msc}{\setcounter{doctype}{2}}

% qualif: qualifica��o de doutorado
\DeclareOption{qualif}{\setcounter{doctype}{3}}

% phd: tese de doutorado
\DeclareOption{phd}{\setcounter{doctype}{4}}

% defesa: s� frente, espa�amento 1,5 e menos p�ginas iniciais
\DeclareOption{defesa}{\setcounter{docversion}{0}}

% aprovada: frente/verso, espa�amento 1 e mais p�ginas iniciais
\DeclareOption{aprovada}{\setcounter{docversion}{1}}

% demais op��es devem ser repassadas � classe book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% processa as opcoes definidas acima
\ProcessOptions

%------------------------------------------------------------------------------

% alguns pacotes necess�rios
\RequirePackage{indentfirst} % indentar o primeiro par�grafo (portugu�s)
\RequirePackage{ifthen}      % controle de fluxo (usado nesta classe)

%------------------------------------------------------------------------------

% Definir a classe de base
\ifthenelse{\value{docversion} = 0}
{
  % default: usar "oneside"
  \LoadClass[12pt,a4paper,oneside]{book}
}{
  % aprovada: usar "twoside"
  \LoadClass[12pt,a4paper,twoside]{book}
}

%------------------------------------------------------------------------------

% defini��o dos fontes usados no documento
\RequirePackage[T1]{fontenc}  % caracteres acentuados corretos no PDF
\RequirePackage{txfonts}      % Times
\RequirePackage{mathptmx}     % Times em f�rmulas matem�ticas
\RequirePackage[scaled=.90]{helvet} %Helvetica/Arial
\RequirePackage{courier}      % Courier

%------------------------------------------------------------------------------

% dimens�es da p�gina e margens
\RequirePackage{geometry}
\geometry{a4paper}
\geometry{right=2cm,left=2cm,top=3cm,bottom=3cm}
\geometry{bindingoffset=1cm}

% indenta��o dos par�grafos � +/- 1/2"
\setlength{\parindent}{4em}

% espa�amento entre linhas
\RequirePackage{setspace}
\ifthenelse{\value{docversion} = 0}
{
  % default: espa�amento 1.5
  \onehalfspacing
}{
  % aprovada: espa�amento 1
  \singlespacing
}

% relaxar o espa�amento entre caracteres
\sloppy

% impedir linhas �rf�s/vi�vas (linhas isoladas no in�cio/fim de uma p�gina)
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty 10000
\raggedbottom

%------------------------------------------------------------------------------

% defini��o dos cabe�alhos das p�ginas
\pagestyle{myheadings}

%------------------------------------------------------------------------------

% defini��o do formato da bibliografia default
\bibliographystyle{apalike}  % [Maziero, 2007], [Maziero et al., 2006]

%------------------------------------------------------------------------------

% defini��o do texto de apresenta��o dos documentos

% partes fixas do texto
\def\@programa{Programa de P\'os-Gradua\c{c}\~ao em Computa\c{c}\~ao Aplicada da
Universidade Tecnol\'ogica Federal do Paran\'a}

% para PDM
\ifthenelse{\value{doctype} = 1}
{\def\@description{Projeto de Disserta\c{c}\~ao submetido ao \@programa\ como
  requisito parcial para a obten\c{c}\~ao do t\'{\i}tulo de Mestre em 
  Computa\c{c}\~ao Aplicada.}}
{}

% para MSc
\ifthenelse{\value{doctype} = 2}
{\def\@description{Disserta\c{c}\~ao submetida ao \@programa\ como requisito 
  parcial para a obten\c{c}\~ao do t\'{\i}tulo de Mestre em
  Computa\c{c}\~ao Aplicada.}}
{}

% para Qualifica��o
\ifthenelse{\value{doctype} = 3}
{\def\@description{Projeto de Tese submetido ao \@programa\ como requisito 
  parcial para a obten\c{c}\~ao do t\'{\i}tulo de Doutor em 
  Computa\c{c}\~ao Aplicada.}}
{}

% para Doutorado
\ifthenelse{\value{doctype} = 4}
{\def\@description{Tese submetida ao \@programa\ como requisito parcial para
  a obten\c{c}\~ao do t\'{\i}tulo de Doutor em 
  Computa\c{c}\~ao Aplicada.}}
{}

% o tipo de documento nao foi informado
\ifthenelse{\value{doctype} = 0}
{\PackageError{ppgca}{Tipo de documento indefinido}
 {Voce deve escolher uma opcao entre : pdm, msc, phd ou qualif.}}
{}

%------------------------------------------------------------------------------

% defini��o de autor, orientador, local, �rea, palavras-chave, etc

% valores default (n�o mud�-los, pois poder�o ser testados em macros)
\def\@advisor{???}      % orientador
\def\@coadvisor{???}    % co-orientador
\def\@field{???}        % �rea de concentra��o
\def\@local{???}        % local
\newcommand{\advisor}[1]{\def\@advisor{#1}}
\newcommand{\coadvisor}[1]{\def\@coadvisor{#1}}
\newcommand{\field}[1]{\def\@field{#1}}
\newcommand{\local}[1]{\def\@local{#1}}

% palavras-chave e keywords
\def\@pchavea{???}      % palavra-chave A
\def\@pchaveb{???}      % palavra-chave B
\def\@pchavec{???}      % palavra-chave C
\def\@keyworda{???}     % keyword A
\def\@keywordb{???}     % keyword B
\def\@keywordc{???}     % keyword C
\newcommand{\keywords}[6]{\def\@pchavea{#1}\def\@pchaveb{#2}\def\@pchavec{#3}
\def\@keyworda{#4}\def\@keywordb{#5}\def\@keywordc{#6}}

%------------------------------------------------------------------------------

% ambientes da parte inicial do documento

% resumo
\newenvironment{resumo}
{\begin{center}{\Huge\textbf{Resumo}}\end{center}\addcontentsline{toc}{chapter}{Resumo}}
{\vspace{1em}\noindent\textbf{Palavras-chave:} \@pchavea, \@pchaveb, \@pchavec.\vfill\cleardoublepage}

% abstract
\newenvironment{abstract}
{\begin{center}{\Huge\textbf{Abstract}}\end{center}\addcontentsline{toc}{chapter}{Abstract}}
{\vspace{1em}\noindent\textbf{Keywords:} \@keyworda, \@keywordb, \@keywordc.\vfill\cleardoublepage}

% agradece
\newenvironment{agradece}
{\begin{center}{\Huge\textbf{Agradecimentos}}\end{center}}
{\vfill\cleardoublepage}

% dedica
\newenvironment{dedica}
{\vspace*{\fill}\hfill\begin{minipage}[t]{6cm}\em}
{\end{minipage}\cleardoublepage}

% listasimb
\newenvironment{listasimb}
{\vspace*{13ex}\noindent
{\Huge\textbf{Lista de S\'{\i}mbolos}}
\addcontentsline{toc}{chapter}{Lista de S\'{\i}mbolos}
\vspace{8ex}}
{\vfill\cleardoublepage}

% listaabrev
\newenvironment{listaabrev}
{\vspace*{13ex}\noindent
{\Huge\textbf{Lista de Abrevia\c{c}\~oes}}
\addcontentsline{toc}{chapter}{Lista de Abrevia\c{c}\~oes}
\vspace{8ex}}
{\vfill\cleardoublepage}

%------------------------------------------------------------------------------

% constru��o das p�ginas iniciais

\renewcommand{\maketitle}
{
  % primeira capa (s� na vers�o aprovada)
  \ifthenelse{\value{docversion} = 1}
  {
    \thispagestyle{empty}
    \begin{center}
    \textsc{\Large\@author}
    \end{center}
    \vfill\vfill
    \begin{center}
    \begin{doublespace}
    \textbf{\textsc{\Huge\@title}}
    \end{doublespace}
    \end{center}
    \vfill
    \hfill\parbox{9cm}{\@description}
    \vfill
    \begin{center}
    \@local\\\@date
    \end{center}
    \cleardoublepage
  }{}
  
  % segunda capa
  \thispagestyle{empty}
  \begin{center}
  \textsc{\Large\@author}
  \end{center}
  \vfill\vfill
  \begin{center}
  \begin{doublespace}
  \textbf{\textsc{\Huge\@title}}
  \end{doublespace}
  \end{center}
  \vfill
  \hfill\parbox{9cm}{\@description
    \vspace{1em}\\
    \'Area de concentra\c{c}\~ao: \emph{\@field}
    \vspace{1em}\\
    Orientador: \@advisor\\
    \ifthenelse{\equal{\@coadvisor}{???}}{}{Co-orientador: \@coadvisor}
  }
  \vfill
  \begin{center}
  \@local\\\@date
  \end{center}

  % ficha catalogr�fica (s� na vers�o aprovada)
  \ifthenelse{\value{docversion} = 1}
  {
    \clearpage
    \include{ficha}
  }
  { }
  \cleardoublepage

  % p�gina de aprova��o (s� na vers�o aprovada)
  \ifthenelse{\value{docversion} = 1}
  {
    \begin{center}
    \emph{Esta folha deve ser substitu\'{\i}da pela ata de defesa devidamente
    assinada,\\que ser\'a fornecida pela secretaria do programa ap\'os a
    defesa.}
    \end{center}
    \cleardoublepage
  }{}

  % dedicatoria e agradecimentos (s� na vers�o aprovada)
  \ifthenelse{\value{docversion} = 1}
  {
    \include{agradece}
    \cleardoublepage
  }{} 
}

%------------------------------------------------------------------------------
