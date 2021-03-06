{smcl}
{* *! version 1.0 10jul2016}{...}
{vieweralsosee "fegen" "help fegen"}{...}
{vieweralsosee "fsort" "help fsort"}{...}
{vieweralsosee "fcollapse" "help fcollapse"}{...}
{vieweralsosee "fmerge" "help fmerge"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] egen" "help egen"}{...}
{vieweralsosee "[R] sort" "help sort"}{...}
{vieweralsosee "[R] collapse" "help collapse"}{...}
{vieweralsosee "[R] merge" "help merge"}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "moremata" "help moremata"}{...}
{vieweralsosee "reghdfe" "help reghdfe"}{...}
{viewerjumpto "Syntax" "ftools##syntax"}{...}
{viewerjumpto "Properties and methods" "ftools##properties"}{...}
{viewerjumpto "Description" "ftools##description"}{...}
{viewerjumpto "Example" "ftools##example"}{...}
{viewerjumpto "Remarks" "ftools##remarks"}{...}
{viewerjumpto "Source code" "ftools_source"}{...}
{viewerjumpto "Author" "ftools##contact"}{...}

{title:Title}

{p2colset 5 15 20 2}{...}
{p2col :{cmd:FTOOLS} {hline 2}}Mata commands for factor variables{p_end}
{p2colreset}{...}

{marker syntax}{...}
{title:Syntax}

{p 8 16 2}
{it:class Factor scalar}
{bind: }{cmd:factor(}{it:varnames} [{cmd:,}
{it:touse}{cmd:,} 
{it:verbose}{cmd:,} 
{it:method}{cmd:,} 
{it:sort_levels}{cmd:,} 
{it:count_levels}{cmd:,} 
{it:hash_ratio}]{cmd:)}

{p 8 16 2}
{it:class Factor scalar}
{bind: }{cmd:_factor(}{it:data} [{cmd:,}
{it:integers_only}{cmd:,} 
{it:verbose}{cmd:,} 
{it:method}{cmd:,} 
{it:sort_levels}{cmd:,} 
{it:count_levels}{cmd:,} 
{it:hash_ratio}]{cmd:)}

{p 8 16 2}
{it:void}{bind: }{cmd:store_levels(}
{it:varnames}{cmd:,}
{it:newvar} [{cmd:,}
{it:touse}{cmd:,} 
{it:verbose}{cmd:,} 
{it:method}{cmd:,} 
{it:sort_levels}{cmd:,} 
{it:hash_ratio}]{cmd:)}

{marker arguments}{...}
{synoptset 38 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent:* {it:string} varnames}names of variables that identify the factors{p_end}
{synopt:{it:string} touse}name of dummy {help mark:touse} variable{p_end}
{synopt:{it:real} verbose}1 to display debug information{p_end}
{synopt:{it:string} method}hashing method: mata, hash0, hash1, hash2; default is {it:mata} (auto-choose){p_end}
{synopt:{it:real} sort_levels}set to 0 under {it:hash1} to increase speed, but the new levels will not match the order of the varlist{p_end}
{synopt:{it:real} count_levels}set to 0 under {it:hash0} to increase speed, but the {it:F.counts} vector will not be generated{p_end}
{synopt:{it:real} hash_ratio}(advanced) size of the hash vector compared to the maximum number of keys (often num. obs.){p_end}

{synopt:{it:string} data}transmorphic matrix with the group identifiers{p_end}
{synopt:{it:string} integers_only}whether {it:data} is numeric and takes only {it:integers} or not (unless you are sure of the former, set it to 0){p_end}
{p2colreset}{...}


{marker properties}{...}
{title:Properties and methods}

{pstd}
First, create a Factor object:

{p 8 8 2}
{it:class Factor scalar F}{break}
{it:F }{cmd:=}{bind: }{cmd:factor(}{it:varnames}{cmd:)}

{marker arguments}{...}
{synoptset 38 tabbed}{...}

{synopthdr:available after F=factor(...)}
{synoptline}
{synopt:{it:real} F{cmd:.num_levels}}number of levels (distinct values) of the factor{p_end}
{synopt:{it:real} F{cmd:.num_obs}}number of observations of the sample used to create the factor ({cmd:c(N)} if touse was empty){p_end}
{synopt:{it:real colvector} F{cmd:.levels}}levels of the factor; dimension {cmd:F.num_obs x 1}; range: {cmd:{1, ..., F.num_levels}}{p_end}
{synopt:{it:transmorphic matrix} F{cmd:.keys}}values of the input varlist that correspond to the factor levels; dimension {cmd:F.num_levels x 1}; unordered if sort_levels==0{p_end}
{synopt:{it:real vector} F{cmd:.counts}}frequencies of each level (in the sample set by touse); dimension {cmd:F.num_levels x 1}; will be empty if count_levels==0{p_end}

{synopt:{it:string rowvector} F{cmd:.varlist}}name of variables used to create the factor{p_end}
{synopt:{it:string rowvector} F{cmd:.varformats}}formats of the input variables{p_end}
{synopt:{it:string rowvector} F{cmd:.varlabels}}labels of the input variables{p_end}
{synopt:{it:string rowvector} F{cmd:.varvaluelabels}}value labels attached to the input variables{p_end}
{synopt:{it:string rowvector} F{cmd:.vartypes}}types of the input variables{p_end}
{synopt:{it:string rowvector} F{cmd:.vl}}value label definitions used by the input variables{p_end}
{synopt:{it:string} F{cmd:.touse}}name of touse variable{p_end}

{synopt:{it:void} F{cmd:.store_levels(}{newvar}{cmd:)}}save
the levels back into the dataset (using the same {it:touse}){p_end}
{synopt:{it:void} F{cmd:.store_keys(}[{it:sort}]{cmd:)}}save
the original key variables into a reduced dataset, including formatting and labels. If {it:sort} is 1, Stata will report the dataset as sorted{p_end}
{synopt:{it:void} F{cmd:.panelsetup()}}compute auxiliary vectors {it:F.info}
and {it:F.p} (see below); used in panel computations{p_end}


{synopthdr:available after F.panelsetup()}
{synoptline}
{synopt:{it:transmorphic matrix} F{cmd:.sort(}{it:data}{cmd:)}}equivalent to
{cmd:data = data[F.p, .]}
but calls {cmd:F.panelsetup()} if required; {it:data} is a {it:transmorphic matrix}{p_end}
{synopt:{it:void} F{cmd:._sort(}{it:data}{cmd:)}}in-place version of {cmd:.paneldata()} (slower but uses less memory){p_end}
{synopt:{it:real vector} F{cmd:.info}}equivalent to {help mf_panelsetup:panelsetup()
(returns a {it:(num_levels X 2)} matrix with start and end positions of each level/panel).
{bf:Note:} instead of using {cmd:F.info} direclty, call panelsubmatrix():
{cmd:x = panelsubmatrix(X, i, F.info)} (see the example at the end){p_end}
{synopt:{it:real vector} F{cmd:.p}}equivalent to {cmd:order(F.levels)}
but implemented with a counting sort that is asymptotically
faster ({it:O(N)} instead of {it:O(N log N)}{p_end}
{p2colreset}{...}


{pstd}Notes:

{synoptset 3 tabbed}{...}
{synopt:- }If you just downloaded the package and want to use the Mata functions directly (instead of the Stata commands), run {stata ftools} to create the library.{p_end}
{synopt:- }If you already have your data in Mata, use {cmd:F = _factor(data)} instead of {cmd:F = factor(varlist)}{p_end}



{marker description}{...}
{title:Description}

{pstd}
The {it:Factor} object is a key component of several commands that
manipulate data without having to sort it beforehand:

{pmore}- {help fcollapse}{p_end}
{pmore}- {help fegen:fegen group}{p_end}
{pmore}- {help fsort} (note: this is O(N) but with a high constant term){p_end}
{pmore}- fmerge{p_end}
{pmore}- fcontract{p_end}
{pmore}- freshape{p_end}

{pstd}
It rearranges one or more categorical variables into a new variable that takes values from 1 to F.num_levels. You can then efficiently sort any other variable by this, in order to compute groups statistics and other manipulations.

{pstd}
For technical information, see
{browse "http://stackoverflow.com/questions/8991709/why-are-pandas-merges-in-python-faster-than-data-table-merges-in-r/8992714#8992714":[1]}
{browse "http://wesmckinney.com/blog/nycpython-1102012-a-look-inside-pandas-design-and-development/":[2]},
and to a lesser degree
{browse "https://my.vertica.com/docs/7.1.x/HTML/Content/Authoring/AnalyzingData/Optimizations/AvoidingGROUPBYHASHWithProjectionDesign.htm":[3]}.


{marker usage}{...}
{title:Usage}

{pstd}
If you only want to create identifiers based on one or more variables,
run something like:

{inp}sysuse auto, clear
mata: store_levels("foreign turn", "id")
{txt}

{pstd}
More complex scenarios would involve some of the following:

{inp}sysuse auto, clear
* Create factors for foreign data only
mata: F = factor("turn", "foreign")
* Report number of levels, obs. in sample, and keys
mata: F.num_levels
mata: F.num_obs
mata: F.keys, F.counts
* View new levels
mata: F.levels[1::10]
* Store back new levels (on the same sample)
mata: F.store_levels("id")
* Verify that the results are correct
sort id
li turn foreign id in 1/10
{txt}

Finally, the example below shows how to process data for each level of the factor (like {help bysort}). It does so by combining {cmd:F.sort()} with {help mf_panelsetup:panelsubmatrix()}.


{marker example}{...}
{title:Example}

{pstd}
This code runs a regression for each category of {it:turn}:

{inp}clear all
mata:
real matrix reg_by_group(string depvar, string indepvars, string byvar) {
	class Factor scalar			F
	real scalar				i
	real matrix				X, Y, x, y, betas

	F = factor(byvar)
	Y = F.sort(st_data(., depvar))
	X = F.sort(st_data(., tokens(indepvars)))
	betas = J(F.num_levels, 1 + cols(X), .)
	
	for (i = 1; i <= F.num_levels; i++) {
		y = panelsubmatrix(Y, i, F.info)
		x = panelsubmatrix(X, i, F.info) , J(rows(y), 1, 1)
		betas[i, .] = qrsolve(x, y)'
	}
	return(betas)
}
end
sysuse auto
mata: reg_by_group("price", "weight length", "foreign")
{text}

{marker remarks}{...}
{title:Remarks}

{pstd}
All-numeric and all-string varlists are allowed, but
hybrid varlists (where some but not all variables are strings) are not possible
due to Mata limitations.
As a workaround, first convert the string variables to numeric (e.g. using {cmd:store_levels()}) and then run your intended command.

{pstd}
You can pass as {varlist} a string like "turn trunk"
or a tokenized string like ("turn", "trunk").

{pstd}
To generate a group identifier, most commands first sort the data by a list of keys (such as {it:gvkey, year}) and then ask if the keys differ from one observation to the other.
Instead, {cmd:ftools} exploits the insights that sorting the data is not required to create an identifier,
and that once an identifier is created, we can then use a {it:counting sort} to sort the data in {it:O(N)} time instead of {it:O log(N)}.

{pstd}
To create an identifier (that takes a value in {1, {it:#keys}}) we first match each key (composed by one or more numbers and strings) into a unique integer.
 For instance, the key {it:gvkey=123, year=2010} is assigned the integer {it:4268248869} with the Mata function {cmd:hash1}.
 This identifier can then be used as an index when accessing vectors, bypassing the need for sorts.

{pstd}
The program tries to pick the hash function that best matches the dataset and input variables.
For instance, if the input variables have a small range of possible values (e.g. if they are of {it:byte} type), we select the {it:hash0} method, which uses a (non-minimal) perfect hashing but might consume a lot of memory.
Alternatively, {it:hash1} is used, which adds {browse "https://www.wikiwand.com/en/Open_addressing":open addressing} to Mata's
{help mf_hash1:hash1} function to create a form of open addressing (that is more efficient than Mata's {help mf_asarray:asarray}).


{marker source_code}{...}
{title:Source code}

{pstd}
You have two options:

{pmore}
a) check online here: {browse "https://github.com/sergiocorreia/ftools/source"}

{pmore}
b) Type {stata findfile ftools_type_aliases.mata} and {stata findfile ftools.mata}, and then open those files with {stata doedit "`r(fn)'"}


{marker author}{...}
{title:Author}

{pstd}Sergio Correia{break}
Fuqua School of Business, Duke University{break}
Email: {browse "mailto:sergio.correia@gmail.com":sergio.correia@gmail.com}{break}
Project URL: {browse "https://github.com/sergiocorreia/ftools"}{break}
{p_end}

