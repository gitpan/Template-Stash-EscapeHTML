#!perl -T

use Test::More tests => 2;
use Template::Stash::EscapeHTML;
use Template;

my $html =<<'HTML';
[% FOREACH a = list %]
[% a %]
[% END %]
[% var %]
HTML

my $tt = Template->new({
    STASH => Template::Stash::EscapeHTML->new,
});
$tt->process(\$html, { 
    list => ['<a href="http://www.example.com/">', '<h1>hoge</h1>'],
    var => '<script>alert("foo");</script>',
}, \my $output);

like($output, qr{&lt;h1&gt;});
like($output, qr{&lt;script&gt;alert\(&quot;foo&quot;\);&lt;/script&gt;})
