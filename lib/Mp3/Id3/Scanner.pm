package Mp3::Id3::Scanner;
use Moo;
use Image::ExifTool qw(:Public);
use Image::ExifTool::ID3;
use Mp3::Id3::Scanner::ID3v1;
use Mp3::Id3::Scanner::ID3v2;

has [qw|
    id3v1 
    id3v2
    duration
    audio_bitrate
    audio_layer
    channel_mode
    size
    type
    mime_type
|] => ( is => "rw" );

before 'scan' => sub {
    my $self = shift;
    $self->id3v1(Mp3::Id3::Scanner::ID3v1->new);
    $self->id3v2(Mp3::Id3::Scanner::ID3v2->new);
    for (qw|duration audio_bitrate audio_layer channel_mode size type mime_type|) {
        $self->$_(undef);
    }
};

sub scan {
    my $self = shift;
    my $file = shift;
    return 0 if ! -e $file;
    my $info = ImageInfo( $file );
#   use DDP;warn p $info;
    # use DDP;    warn p $info;
    # todo add option for file handler and strng
    $self->id3v1->parse_id3v1( $info );
    $self->id3v2->parse_id3v2( $info );

    $self->duration($info->{ Duration }) if exists $info->{ Duration };
    $self->audio_bitrate($info->{ AudioBitrate }) if exists $info->{ AudioBitrate };
    $self->audio_layer($info->{ AudioLayer }) if exists $info->{ AudioLayer };
    $self->channel_mode($info->{ ChannelMode }) if exists $info->{ ChannelMode };
    $self->size($info->{ FileSize }) if exists $info->{ FileSize };
    $self->type($info->{ FileType }) if exists $info->{ FileType };
    $self->mime_type($info->{ MIMEType }) if exists $info->{ MIMEType };

    $self;
}

1;

=head1 Mp3::Id3::Scanner

Yet another tool for scanning id3v1 and id3v2 of mp3 files.

The purpose of this tool is to scan mp3 and give you access to id3v1 and id3v2 values of mp3. The goal is to provide a way to scan mp3 and dispose fields just like Winamp used as standard.

* At this moment the tool only READS and *not* write.

=head2 Synopsis

    my $file = "./t/quartersec.mp3";
    my $mp3 = Mp3::Id3::Scanner->new;
    $mp3->scan( $file );
    
    # ID3 V1
    $mp3->id3v1->album
    $mp3->id3v1->artist
    $mp3->id3v1->track
    $mp3->id3v1->title
    $mp3->id3v1->year
    $mp3->id3v1->genre
    $mp3->id3v1->comment

    # ID3 V2
    $mp3->id3v2->track
    $mp3->id3v2->disc
    $mp3->id3v2->publisher
    $mp3->id3v2->title
    $mp3->id3v2->artist
    $mp3->id3v2->album
    $mp3->id3v2->year
    $mp3->id3v2->genre
    $mp3->id3v2->comment
    $mp3->id3v2->album_artist
    $mp3->id3v2->composer
    $mp3->id3v2->original_artist
    $mp3->id3v2->copyright
    $mp3->id3v2->url
    $mp3->id3v2->encoded
    $mp3->id3v2->bpm

=head2 Special Thanks to

authors of Image-ExifTool
http://www.xamuel.com/blank-mp3s/  for very short blank mp3 used for testing

=head2 Author

Hernan Lopes

=cut

