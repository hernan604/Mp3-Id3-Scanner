use Test::More;
use Mp3::Id3::Scanner;
my $file = "./t/quartersec.mp3";
my $mp3 = Mp3::Id3::Scanner->new;
$mp3->scan( $file );

is( $mp3->id3v1->album  , 'Album id3v1', '' );
is( $mp3->id3v1->artist , 'Artist id3v1', '' );
is( $mp3->id3v1->track  , '1', '' );
is( $mp3->id3v1->title  , 'Title id3v1', '' );
is( $mp3->id3v1->year   , '1111', '' );
is( $mp3->id3v1->genre  , 'Psychedelic', '' );
is( $mp3->id3v1->comment, 'Comment id3v1', '' );

is( $mp3->id3v2->track      , '2', '' );
is( $mp3->id3v2->disc       , '4', '' );
is( $mp3->id3v2->publisher  , 'Publisher id3v2', '' );
is( $mp3->id3v2->title      , 'Title id3v2', '' );
is( $mp3->id3v2->artist     , 'Artist id3v2', '' );
is( $mp3->id3v2->album      , 'Album id3v2', '' );
is( $mp3->id3v2->year       , '2222', '' );
is( $mp3->id3v2->genre      , 'Psytrance', '' );
is( $mp3->id3v2->comment    , 'Comment id3v2', '' );
is( $mp3->id3v2->album_artist, 'AlbumArtist id3v2', '' );
is( $mp3->id3v2->composer   , 'Composer id3v2', '' );
is( $mp3->id3v2->original_artist, 'OrigArtist id3v2', '' );
is( $mp3->id3v2->copyright  , 'Copyright id3v2', '' );
is( $mp3->id3v2->url        , 'Url id3v2', '' );
is( $mp3->id3v2->encoded    , 'Encoded id3v2', '' );
is( $mp3->id3v2->bpm        , '123', '' );

is( $mp3->duration          , '0.31 s (approx)', '');
is( $mp3->audio_bitrate     , '128 kbps', '');
is( $mp3->audio_layer       , '3', '');
is( $mp3->channel_mode      , 'Single Channel', '');
is( $mp3->size              , '7.0 kB', '');
is( $mp3->type              , 'MP3', '');
is( $mp3->mime_type         , 'audio/mpeg', '');

#more tests needed
done_testing;
