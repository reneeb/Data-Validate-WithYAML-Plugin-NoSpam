package Data::Validate::WithYAML::Plugin::NoSpam;

use warnings;
use strict; 

use Carp;

# ABSTRACT: Plugin to check that a given text is no spam.

our $VERSION = '0.03';

=head1 SYNOPSIS

The check is done with heuristics. It checks that there are no
<a href="..."> or [url=""] tags in the text...

    use Data::Validate::WithYAML::Plugin::NoSpam;

    my $foo = Data::Validate::WithYAML::Plugin::NoSpam->check(
       'This is a <a href="anything">Spam-Link</a>',
    );
    ...
    
    # use the plugin via Data::Validate::WithYAML
    
    use Data::Validate::WithYAML;
    
    my $text      = 'This is a <a href="anything">Spam-Link</a>';
    my $validator = Data::Validate::WithYAML->new( 'test.yml' );
    print "yes" if $validator->check( 'textfield', $text );

test.yml

  ---
  step1:
      textfield:
          plugin: NoSpam
          type: required
  

=head1 SUBROUTINES

=head2 check

=cut

sub check {
    my ($class, $value) = @_;
    
    croak "no value to check" unless defined $value;
    
    if ( $value =~ /(?:\[url|<a href)/ ) {
        return 0;
    }
    elsif ( $value =~ /viagra|cialis/i ) {
        return 0;
    }
    
    return 1;
}

1; # End of Data::Validate::WithYAML::Plugin::NoSpam
