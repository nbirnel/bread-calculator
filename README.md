bread-calculator
---------
A ruby gem to calculate baker's percentages

Installation
---------
`gem install bakers_percentage`

or, if you want the latest and the greatest, 
or if you want the man page installed:

    git clone https://github.com/bread-calculator
    cd bread-calculator
    rake install

(use sudo as necessary)

Runtime Requirements
---------
ruby >= 1.9.2

Build Requirements
---------
rake

Developer Requirements
---------
groff

Inspiration and History
---------
Baker's percentages make baking easier, but I don't like to do the math.

License
---------
© 2014 Noah Birnel
MIT license

Man page
---------
<html>
<head>
<meta name="generator" content="groff -Thtml, see www.gnu.org">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta name="Content-Style" content="text/css">
<title>bread-calc</title>

</head>
<body>

<h1 align="center">bread-calc</h1>

<a href="#NAME">NAME</a><br>
<a href="#SYNOPSIS">SYNOPSIS</a><br>
<a href="#DESCRIPTION">DESCRIPTION</a><br>
<a href="#OPTIONS">OPTIONS</a><br>
<a href="#EXAMPLES">EXAMPLES</a><br>
<a href="#FORMATS">FORMATS</a><br>
<a href="#SEE ALSO">SEE ALSO</a><br>
<a href="#BUGS">BUGS</a><br>
<a href="#LICENSE">LICENSE</a><br>

<hr>


<h2>NAME
<a name="NAME"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">bread-calc
&minus; calculate baker&rsquo;s percentages</p>

<h2>SYNOPSIS
<a name="SYNOPSIS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>bread-calc
[OPTIONS] [FILE]</b></p>

<h2>DESCRIPTION
<a name="DESCRIPTION"></a>
</h2>



<p style="margin-left:11%; margin-top: 1em"><b>bread-calc</b>
parses a nearly free-form bread recipe in file FILE, or from
standard in. By default, the canonical representation of the
recipe is printed to standard out. Optionally, the weight,
or bakers percentage formula can be generated, or the recipe
can by scaled up or down.</p>

<h2>OPTIONS
<a name="OPTIONS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>--help</b>
print this help</p>


<p style="margin-left:11%; margin-top: 1em"><b>--summary</b>
print a baker&rsquo;s percentage summary</p>


<p style="margin-left:11%; margin-top: 1em"><b>--weight</b>
print the weight</p>

<p style="margin-left:11%; margin-top: 1em"><b>--scale-by
FACTOR</b> regenerate the recipe, scaling up or down by
FACTOR</p>

<h2>EXAMPLES
<a name="EXAMPLES"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>bread-calc
--summary sample.recipe</b></p>

<h2>FORMATS
<a name="FORMATS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">The recipe
format consists of a metadata prelude, and steps.</p>

<p style="margin-left:11%; margin-top: 1em">In prelude
lines, anything before a colon is considered to be the name
of a metadata field; anything after the colon is a value to
populate. Lines without colons are continuations of the
&rsquo;notes&rsquo; field. I suggest having at least a
&rsquo;name&rsquo; field.</p>

<p style="margin-left:11%; margin-top: 1em">A line starting
with a hyphen ends the prelude and starts the first
step.</p>

<p style="margin-left:11%; margin-top: 1em">Each step is
delimited by one or more blank lines.</p>

<p style="margin-left:11%; margin-top: 1em">Any line in a
step starting with a space or a blank is an ingredient,
consisting of quantity, units, and the ingredient itself.
<b>bread-calc</b> will attempt to guess at the type of
ingredient, but you can always force it by including one of
the words &rsquo;flour&rsquo;, &rsquo;liquid&rsquo;, or
&rsquo;additive&rsquo; in the line.</p>

<h2>SEE ALSO
<a name="SEE ALSO"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><i>ruby(1) <br>
http://en.wikipedia.org/wiki/Baker%27s_percentage <br>
http://rubygems.org/gems/bread_calculator</i></p>

<h2>BUGS
<a name="BUGS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">It is
cheerfully assumed that all units are grams.</p>

<p style="margin-left:11%; margin-top: 1em">It is undefined
how &rsquo;liquid flour additive&rsquo; is parsed, but
don&rsquo;t expect anything good.</p>

<h2>LICENSE
<a name="LICENSE"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">Copyright 2014
Noah Birnel</p>

<p style="margin-left:11%; margin-top: 1em">MIT License</p>
<hr>
</body>
</html>
