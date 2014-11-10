package Mp3::Id3::Scanner::ID3v2;
use Moo;

has [qw|
    track
    disc
    publisher
    title
    artist
    album
    year
    genre
    comment
    album_artist
    composer
    original_artist
    copyright
    url
    encoded
    bpm
|] => ( is => "rw" );

#   has id3v2_tag_mapping => ( is => "rw", default => sub {
#       #maps tags to Image-ExifTool tag names
#       {
#           track       => 'Track',
#           disc        => 'PartOfSet',
#           publisher   => 'Publisher',
#           title       => 'Title',
#           artist      => 'Artist',
#           album       => 'Album',
#           year        => 'Year',
#           genre       => 'Genre',
#           comment     => 'Comment',
#           album_artist=> 'Band',
#           composer    => 'Composer',
#           orig_artist => 'OriginalArtist',
#           copyright   => 'Copyright',
#           url         => 'UserDefinedURL',
#           encoded     => 'EncodedBy',
#           bpm         => 'BeatsPerMinute',
#       }
#   } );

sub parse_id3v2 {
    my $self = shift;
    my $info = shift;
    $self->track( $info->{'Track'} ) if exists $info->{ 'Track' };
    $self->disc( $info->{ 'PartOfSet' } ) if exists $info->{ 'PartOfSet' };
    $self->publisher( $info->{ 'Publisher' } ) if exists $info->{ 'Publisher' };
    $self->title( $info->{ 'Title' } ) if exists $info->{ 'Title' };
    $self->artist( $info->{ 'Artist' } ) if exists $info->{ 'Artist' };
    $self->album( $info->{ 'Album' } ) if exists $info->{ 'Album' };
    $self->year( $info->{ 'Year' } ) if exists $info->{ 'Year' };
    $self->genre( $info->{ 'Genre' } ) if exists $info->{ 'Genre' };
    $self->album_artist( $info->{ 'Band' } ) if exists $info->{ 'Band' };
    $self->composer( $info->{ 'Composer' } ) if exists $info->{ 'Composer' };
    $self->original_artist( $info->{ 'OriginalArtist' } ) if exists $info->{ 'OriginalArtist' };
    $self->copyright( $info->{ 'Copyright' } ) if exists $info->{ 'Copyright' };
    $self->url( $info->{ 'UserDefinedURL' } ) if exists $info->{ 'UserDefinedURL' };
    $self->encoded( $info->{ 'EncodedBy' } ) if exists $info->{ 'EncodedBy' };
    $self->bpm( $info->{ 'BeatsPerMinute' } ) if exists $info->{ 'BeatsPerMinute' };

    #For some reason comments in v1 can be found as Comment (1) when Comment exist
    #and Comment when Comment-xxx exists... 
    #there might be other variations i am not aware of. let me know if anything.
    if ( exists $info->{ 'Comment (1)' } and exists $info->{ 'Comment' } ) {
        $self->comment( $info->{ 'Comment' } );
    } elsif ( exists $info->{ 'Comment-xxx' } and exists $info->{ Comment } ) {
        $self->comment( $info->{ 'Comment-xxx' } );
    }
}

1;
