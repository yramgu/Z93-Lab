Useful Shortcuts for Sphinx writing
===================================

Second level
------------

.. _chap-example-jump:

Third level
~~~~~~~~~~~

Fourth level
^^^^^^^^^^^^

jump here, :numref:`chap-example-jump`

Fifth level
"""""""""""
 
This is a temporary section, at least in published file to add all the useful special characters people are going to need in one place, just to speed up editing.

Just look at source file and copy

Feel free to add additional items

*   :math:`\alpha > \beta`

*   :math:`n_{\mathrm{offset}} = \sum_{k=0}^{N-1} s_k n_k`

.. math::
    n_{\mathrm{offset}} = \sum_{k=0}^{N-1} s_k n_k

*   25 mm\ :sup:`2` 
*   f\ :sub:`c` 
*   ~70µs 
*   π/2
*   ±5
*   5°
*   µF
*   20 * log\ :sub:`10` (5)
*   See more here: https://tools.oratory.com/altcodes.html
*   cleaner link `here <https://tools.oratory.com/altcodes.html>`__
*   **bold like this**
*   *italics like this*
*   Simple table that doesn't get a table designation
*   backquotes: ``text`` for code samples


* List with nesting, next line needs to be blank!

  * If a set of results has 
  * Item a.
  * Item b.
* Item 2.

+------------+----------------+-------------------------------------------+
| hello      | a              | simple table                              |
+------------+----------------+-------------------------------------------+
| 0.1        | blah           | blah blah                                 |
|            |                |                                           |
| 0.2        | blah2          | blah blah 2                               |
+------------+----------------+-------------------------------------------+

Here's a table with multiple lines per cell

.. |br| raw:: html

    <br>
	
+------------+----------------+-------------------------------------------+
| **Rows**   | **Header**     | **Interesting stuff**                     |
+------------+----------------+-------------------------------------------+
| Row 1      | Merged row     | One item |br|                             |
|            |                | A second item |br|                        |
|            |                | A third item in the third line            |
+------------+                +-------------------------------------------+
| Row 2      |                | Only one item here                        |
+------------+----------------+-------------------------------------------+
| Row 3      | Merged columns                                             |
+------------+----------------+-------------------------------------------+

	

*   Or use a CSV file and you will get a designation, plus neat striping

.. csv-table:: Simple CSV table
   :file: assets/tables/basic_table.csv

*   How about a code snippet?

.. code-block:: python
   :emphasize-lines: 3,5

   def some_function():
       interesting = False
       print 'This line is highlighted.'
       print 'This one is not...'
       print '...but this one is.'   
   
*   Now add a figure, proving this is all really easy

.. figure:: assets/figures/Almost.jpg
   :align: center
   :scale: 50 %
   
   Figure : Likely learning experience
   
.. todo:: 
    * This page is never going to end
    * but who cares?

.. note::
    This is note text. Use a note for information you want the user to
    pay particular attention to.

    If note text runs over a line, make sure the lines wrap and are indented to
    the same level as the note tag. If formatting is incorrect, part of the note
    might not render in the HTML output.

    Notes can have more than one paragraph. Successive paragraphs must
    indent to the same level as the rest of the note.
    
.. warning::
    This is warning text. Use a warning for information the user must
    understand to avoid negative consequences.

    Warnings are formatted in the same way as notes. In the same way,
    lines must be broken and indented under the warning tag.



