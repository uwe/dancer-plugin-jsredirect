package Dancer::Plugin::JSredirect;

$VERSION = 0.01;

use Dancer ':syntax';
use Dancer::Plugin;

use HTML::Entities ();


register js_redirect => sub {
    my ($url) = @_;

    my $js_url = HTML::Entities::encode($url);

    # an URL should not contain \n and \r,
    # ' and " should already be escaped by HTML entities,
    # but let's play safe :)
    $js_url =~ s/'/\\'/g;
    $js_url =~ s/"/\\"/g;
    $js_url =~ s/\n/\\n/g;
    $js_url =~ s/\r/\\r/g;

    return <<"END_OF_HTML";
<html>
    <head>
        <script type="text/javascript">
            top.location.replace('$js_url');
        </script>
    </head>
</html>
END_OF_HTML
};

register_plugin;

1;

