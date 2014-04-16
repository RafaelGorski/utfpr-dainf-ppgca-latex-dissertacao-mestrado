%------------------------------------------------------------------------------

% Esta classe "ppgca" define o padrão para dissertações, teses e documentos
% correlatos produzidos no Programa de Pós-Graduação em Computação Aplicada
% da Universidade Tecnológica Federal do Paraná, em Curitiba PR.
%
% Esta classe segue o modelo da classe "book" e aceita todas as suas opções.
% Ela também define as seguintes opções específicas:
% 
%    pdm:      Projeto de Dissertação de Mestrado
%    msc:      Dissertação de Mestrado
%    qualif:   qualificação de Doutorado
%    phd:      tese de Doutorado
%    defesa:   versão prévia (só frente, espaçamento 1.5,)
%    aprovada: versão final (frente/verso, espaçamento 1, páginas complementares)

% Os seguintes ambientes e comandos também são definidos:
%
% \advisor{Nome}    : define o orientador
% \coadvisor{Nome}  : define o co-orientador, se houver
% \field{Área}      : define a área de concentração da pesquisa
% \local{Cidade}    : define o local da defesa
% \keywords{}{}...  : define três palavras-chave e três keywords
% \begin{resumo}    : define a página de resumo
% \begin{abstract}  : define a página de abstract
% \begin{agradece}  : define a página de agradecimentos
% \begin{dedica}    : define a página de dedicatória
%
% Software fornecido sob a licença GNU GPL. Pode ser usada e modificada
% livremente, desde que mantidas as informações deste cabeçalho.
%
% Histórico:
%
% 2007/06/01 V0.1
% - versão inicial, por Carlos Maziero (maziero@ppgia.pucpr.br). 
%
% 2007/06/15
% - comando \keywords
% - mais comentários explicativos
% - ajustes para evitar linhas órfãs e viúvas
%
% 2007/08/08 V0.2
% - mudei fontenc para T1, para acertar acentos no PDF
% - mudei package de "txfonts" para "times"
%
% 2007/08/08 V0.3
% - coloquei flag -tA4 no dvips (Makefile e instruções de uso)
%
% 2007/09/02 V0.4
% - listasimb e listabrev
% - resumo, abstract e agradecimentos em negrito
%
% 2008/03/12 V0.5
% - ajustei a ordem das paginas iniciais (resumo, sumário, etc)
%
% 2008/06/03 V0.6
% - substituição do Makefile pelo script build (mais completo)
% - inclusão da opção "final" para gerar a versão final
% - estilo "apalike" para bibliografia
%
% 2008/06/11 V0.7
% - inclusão automatica da ficha catalográfica, agradecimentos
%   e dedicatória na versão final do documento
% - ficha catalográfica no verso da segunda capa
%
% 2008/07/16 V0.8
% - removidos packages obsoletos (vide documento l2tabuen.pdf)
% - dimensões da página definidas com package "geometry"
% - espaçamento: troca de \baselinestretch por \linespread
% - indentação de parágrafo mudou de 12.7mm para 4em
% - trocados \bf e \sc por \textbf e \textsc
% - adotado o package setspace para espaçamento entre linhas
% - linhas do título mais espaçadas sempre, mesmo no modo "final"
% - fontes ajustados para o padrão LaTeX2e
% - ajustada fonte default do package listings para tt footnotesize
% - retirados alguns acentos ISO deste arquivo (compatibilidade UTF8)
% - acentos \'i modificados para \'{\i}
%
% 2008/11/17 V0.9
% - opções "draft" e "final" conflitam com opções de documentclass, 
%   opção "draft" vira default e opção "final" renomeada para "aprovada"
% - corrigida ortografia errada em "Abreviações"
%
% 2009/06/03 V0.9.1
% - incluso exemplo de citação bibliográfica contendo URL
% - ajustes no texto do modelo Cap 1 e 2
%
% 2014/03/18 V0.9.2
% - versão para o PPGCA/UTFPR
% - adicionada opção "defesa"
% - reorganização do texto dos capítulos de exemplo
%
% Ainda por fazer:
% - numeração das páginas iniciais deve ser no pé da página e centralizada
% - conferir/ajustar captions de figura e tabela
% - numeração de equações?
% - automatizar geração da ficha catalográfica

%------------------------------------------------------------------------------

% definição da classe
\ProvidesClass{ppgca}[2014/03/18 V0.9.2 (Carlos Maziero)]

%------------------------------------------------------------------------------

% opções desta classe

% o contador doctype define o tipo de documento
\newcounter{doctype}
\setcounter{doctype}{0}

% o contador docversion define a versão do documento
\newcounter{docversion}
\setcounter{docversion}{0} % default é uma versão pré-defesa

% pdm: projeto de dissertação de mestrado
\DeclareOption{pdm}{\setcounter{doctype}{1}}

% msc: dissertação de mestrado
\DeclareOption{msc}{\setcounter{doctype}{2}}

% qualif: qualificação de doutorado
\DeclareOption{qualif}{\setcounter{doctype}{3}}

% phd: tese de doutorado
\DeclareOption{phd}{\setcounter{doctype}{4}}

% defesa: só frente, espaçamento 1,5 e menos páginas iniciais
\DeclareOption{defesa}{\setcounter{docversion}{0}}

% aprovada: frente/verso, espaçamento 1 e mais páginas iniciais
\DeclareOption{aprovada}{\setcounter{docversion}{1}}

% demais opções devem ser repassadas à classe book
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}

% processa as opcoes definidas acima
\ProcessOptions

%------------------------------------------------------------------------------

% alguns pacotes necessários
\RequirePackage{indentfirst} % indentar o primeiro parágrafo (português)
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

% definição dos fontes usados no documento
\RequirePackage[T1]{fontenc}  % caracteres acentuados corretos no PDF
\RequirePackage{txfonts}      % Times
\RequirePackage{mathptmx}     % Times em fórmulas matemáticas
\RequirePackage[scaled=.90]{helvet} %Helvetica/Arial
\RequirePackage{courier}      % Courier

%------------------------------------------------------------------------------

% dimensões da página e margens
\RequirePackage{geometry}
\geometry{a4paper}
\geometry{right=2cm,left=2cm,top=3cm,bottom=3cm}
\geometry{bindingoffset=1cm}

% indentação dos parágrafos é +/- 1/2"
\setlength{\parindent}{4em}

% espaçamento entre linhas
\RequirePackage{setspace}
\ifthenelse{\value{docversion} = 0}
{
  % default: espaçamento 1.5
  \onehalfspacing
}{
  % aprovada: espaçamento 1
  \singlespacing
}

% relaxar o espaçamento entre caracteres
\sloppy

% impedir linhas órfãs/viúvas (linhas isoladas no início/fim de uma página)
\clubpenalty=10000
\widowpenalty=10000
\displaywidowpenalty 10000
\raggedbottom

%------------------------------------------------------------------------------

% definição dos cabeçalhos das páginas
\pagestyle{myheadings}

%------------------------------------------------------------------------------

% definição do formato da bibliografia default
\bibliographystyle{apalike}  % [Maziero, 2007], [Maziero et al., 2006]

%------------------------------------------------------------------------------

% definição do texto de apresentação dos documentos

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

% para Qualificação
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

% definição de autor, orientador, local, área, palavras-chave, etc

% valores default (não mudá-los, pois poderão ser testados em macros)
\def\@advisor{???}      % orientador
\def\@coadvisor{???}    % co-orientador
\def\@field{???}        % área de concentração
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

% construção das páginas iniciais

\renewcommand{\maketitle}
{
  % primeira capa (só na versão aprovada)
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

  % ficha catalográfica (só na versão aprovada)
  \ifthenelse{\value{docversion} = 1}
  {
    \clearpage
    \include{ficha}
  }
  { }
  \cleardoublepage

  % página de aprovação (só na versão aprovada)
  \ifthenelse{\value{docversion} = 1}
  {
    \begin{center}
    \emph{Esta folha deve ser substitu\'{\i}da pela ata de defesa devidamente
    assinada,\\que ser\'a fornecida pela secretaria do programa ap\'os a
    defesa.}
    \end{center}
    \cleardoublepage
  }{}

  % dedicatoria e agradecimentos (só na versão aprovada)
  \ifthenelse{\value{docversion} = 1}
  {
    \include{agradece}
    \cleardoublepage
  }{} 
}

%------------------------------------------------------------------------------
