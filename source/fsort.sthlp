{smcl}
{* *! version 1.0  10jul2016}{...}
{vieweralsosee "ftools" "help ftools"}{...}
{vieweralsosee "[R] sort" "help sort"}{...}
{vieweralsosee "[R] gsort" "help gsort"}{...}
{viewerjumpto "Syntax" "sort##syntax"}{...}
{title:Title}

{p2colset 5 18 20 2}{...}
{p2col :{cmd:fsort} {hline 2}}Sort by categorical variables{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{p 8 13 2}
{cmd:fsort}
{varlist}
[{cmd:,}{opth g:enerate(newvar)}]

{p 8 13 2}not implemented:
{cmd:fsort}
{varlist}
{ifin}
[{cmd:,}{opth g:enerate(newvar)}]

{p 8 14 2}not implemented:
{cmd:fsort}
[{cmd:+}|{cmd:-}]
{varname}
[[{cmd:+}|{cmd:-}]
{varname} {it:...}]
{ifin}
[{cmd:,}{opth g:enerate(newvar)}]

{marker description}{...}
{title:Description}

{pstd}
{opt fsort} is an alternative to {help sort} and {help gsort}, with some differences:

{synoptset 3 tabbed}{...}
{synopt:1)}It requires the variables to represent categories (it would be quite slow to use it to sort a normal random variable){p_end}
{synopt:2)}{varlist} cannot have both string and numeric variables{p_end}
{synopt:3)}The sort is always stable{p_end}
{synopt:3)}It is faster with several million observations (10m+){p_end}
{synopt:4)}(wip) It allows {it:if} and {it:in} options{p_end}
{p2colreset}{...}

{marker author}{...}
{title:Author}

{pstd}Sergio Correia{break}
Fuqua School of Business, Duke University{break}
Email: {browse "mailto:sergio.correia@gmail.com":sergio.correia@gmail.com}{break}
Project URL: {browse "https://github.com/sergiocorreia/ftools"}{break}
{p_end}

