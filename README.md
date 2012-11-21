# NumberInternationalizer

This gem tries to internationalize numbers and percentages of ruby on rails application.

# Motivation and operation

Rails provides methods to show numbers and percentages to the user in the correct format depending on the language. 

Nevertheless, it doesn't allow to input numbers and percentages in other format rather than ruby format.

To solve this problem, this gem do 4 things:

1. Using a custom version of attribute_normalizer, saves the input of the user as text and transform it to ruby format before validation

2. Adds a validator to verify that the input (as the user specified) is a valid number (using internationalization)

4. If the field is specified as percentage, it adds a before_save call to divide the number by 100. This way you can do math operations with percentage wihtout any complication.

5. Finally, it overrides the number_field use text_field with the value that the user specified before sending the request.

## Installation

Add this line to your application's Gemfile:

    gem 'number_internationalizer', :git => 'git://github.com/bishma-stornelli/number_internationalizer.git'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install number_internationalizer

## Usage

To internationalize numbers or percentages use this method in your model:

    internationalize_number :price                         # For one attribute
    internationalize_numbers :price, :value                # For many attributes
    internationalize_number :progress, :percentage => true # For percentages

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
=======
number_internationalizer
========================
