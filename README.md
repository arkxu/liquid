# Liquid template engine

## New added/changed tags

* truncate : user active_support api to prevent UTF coding chars broken
* mod_by : e.g {{ 11 | mod_by:2 }} #=> 1
* desc : sort elements of the array descending 
* split : split the string to array. e.g {{ "a,b,c" | split ',' }}
* assign : enhanced assign to do advanced operation. e.g {% assign foo = values | size %}

## Introduction

Liquid is a template engine which I wrote for very specific requirements

* It has to have beautiful and simple markup. Template engines which don't produce good looking markup are no fun to use.
* It needs to be non evaling and secure. Liquid templates are made so that users can edit them. You don't want to run code on your server which your users wrote.
* It has to be stateless. Compile and render steps have to be seperate so that the expensive parsing and compiling can be done once and later on you can just render it passing in a hash with local variables and objects.

## Why should I use Liquid

* You want to allow your users to edit the appearance of your application but don't want them to run **insecure code on your server**.
* You want to render templates directly from the database
* You like smarty (PHP) style template engines
* You need a template engine which does HTML just as well as emails
* You don't like the markup of your current templating engine

## What does it look like?

<code>
  <ul id="products">
    {% for product in products %}
      <li>
        <h2>{{product.name}}</h2>
        Only {{product.price | price }}

        {{product.description | prettyprint | paragraph }}
      </li>
    {% endfor %}
  </ul>
</code>

## Howto use Liquid

Liquid supports a very simple API based around the Liquid::Template class.
For standard use you can just pass it the content of a file and call render with a parameters hash.

<pre>
@template = Liquid::Template.parse("hi {{name}}") # Parses and compiles the template
@template.render( 'name' => 'tobi' )              # => "hi tobi"
</pre>

