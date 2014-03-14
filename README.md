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

(use `sudo` as necessary)

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
[![Code Climate](https://codeclimate.com/github/nbirnel/bread-calculator.png)](https://codeclimate.com/github/nbirnel/bread-calculator)<html>
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
Print a brief usage message.</p>


<p style="margin-left:11%; margin-top: 1em"><b>--summary</b>
Print all baker&rsquo;s percentages of the recipe.
Over-rides <b>--scale-by</b></p>

<p style="margin-left:11%; margin-top: 1em"><b>--html</b>
Print recipe as html. Over-rides <b>--weight</b> or
<b>--scale-to.</b></p>


<p style="margin-left:11%; margin-top: 1em"><b>--weight</b>
Print the weight of the recipe. Over-rides <b>--html</b> or
<b>--scale-to.</b></p>

<p style="margin-left:11%; margin-top: 1em"><b>--scale-to
WEIGHT</b> Regenerate the recipe or summary to <b>WEIGHT</b>
total weight. Over-rides <b>--html</b> or
<b>--weight.</b></p>

<p style="margin-left:11%; margin-top: 1em"><b>--scale-by
FACTOR.</b> Regenerate the recipe, scaling up or down by
<b>FACTOR</b> Over-rides <b>--summary.</b></p>

<h2>EXAMPLES
<a name="EXAMPLES"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>bread-calc
--summary sample.recipe</b> summarize a recipe</p>

<p style="margin-left:11%; margin-top: 1em"><b>bread-calc
--scale-by .5 sample.recipe | bread-calc --html
&gt;sample.html</b> halve a recipe and render as html</p>

<h2>FORMATS
<a name="FORMATS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">The recipe
format consists of a metadata prelude followed by steps.</p>

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
consisting of quantity, units, and the ingredient
itself.</p>


<p style="margin-left:11%; margin-top: 1em"><b>bread-calc</b>
makes a crude attempt to guess at the type of ingredient,
but you can always force it by including one of the words
&rsquo;flour&rsquo;, &rsquo;liquid&rsquo;, or
&rsquo;additive&rsquo; in the line.</p>

<p style="margin-left:11%; margin-top: 1em">Here is a brief
example (note that if you are reading this on github, you
won&rsquo;t see the indenting):</p>

<p style="margin-left:17%; margin-top: 1em">name: imaginary
bread <br>
notes: This is a silly fake bread recipe <br>
makes: 1 bad loaf <br>
This line will become part of the notes <br>
--------------------- <br>
Mix:</p>

<p style="margin-left:23%;">500 g flour <br>
300 g water</p>

<p style="margin-left:17%; margin-top: 1em">Bake at
375&deg;</p>

<h2>SEE ALSO
<a name="SEE ALSO"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>ruby(1)</b>
<i><br>
http://en.wikipedia.org/wiki/Baker%27s_percentage <br>
http://rubygems.org/gems/bread_calculator</i></p>

<h2>BUGS
<a name="BUGS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">It is
cheerfully assumed that all units are grams.</p>

<p style="margin-left:11%; margin-top: 1em">It is undefined
how &rsquo;liquid flour additive&rsquo; is parsed, but
don&rsquo;t expect anything sensible.</p>

<h2>LICENSE
<a name="LICENSE"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">Copyright 2014
Noah Birnel</p>

<p style="margin-left:11%; margin-top: 1em">MIT License</p>
<hr>
</body>
</html>
