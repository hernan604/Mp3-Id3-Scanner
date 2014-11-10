package Mp3::Id3::Scanner::ID3v1;
use Moo;

has [qw|
    track
    title
    artist
    album
    year
    genre
    comment
|] => ( is => "rw" );
#   has id3v1_tag_mapping => ( is => "rw", default => sub {
#       #maps tags to Image-ExifTool tag names
#       {
#           track   => 'Track (1)',
#           title   => 'Title (1)',
#           artist  => 'Artist (1)',
#           album   => 'Album (1)',
#           year    => 'Year (1)',
#           genre   => 'Genre (1)',
#           comment => ['Comment (1)', 'Comment'],
#       }
#   } );

sub parse_id3v1 {
    my $self = shift;
    my $info = shift;

    #track
    $self->track( $info->{ 'Track (1)' } ) if ( exists $info->{ 'Track (1)' } );
    $self->title( $info->{ 'Title (1)' } ) if ( exists $info->{ 'Title (1)' } );
    $self->artist( $info->{ 'Artist (1)' } ) if ( exists $info->{ 'Artist (1)' } );
    $self->album( $info->{ 'Album (1)' } ) if exists $info->{ 'Album (1)' };
    $self->year( $info->{ 'Year (1)' } ) if exists $info->{ 'Year (1)' };
    $self->genre( $info->{ 'Genre (1)' } ) if exists $info->{ 'Genre (1)' };

    #For some reason comments in v1 can be found as Comment (1) when Comment exist
    #and Comment when Comment-xxx exists... 
    #there might be other variations i am not aware of. let me know if anything.
    if ( exists $info->{ 'Comment (1)' } ) {
        $self->comment( $info->{ 'Comment (1)' } );
    } elsif ( exists $info->{ 'Comment-xxx' } and exists $info->{ 'Comment' } ) {
        $self->comment( $info->{ 'Comment' } );
    }
}

1;
