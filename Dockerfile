FROM rapi/psgi:1.3404
MAINTAINER Henry Van Styn <vanstyn@cpan.org>

# --
# rapi/psgi "stack" version is psgi-1.3404-a0-02:
#
#   psgi-1.3404 : based on rapi/psgi:1.3404
#   a0          : this docker image is named "rapi/psgi-stack-a0"
#   02          : sub version 02
#
# This is an informational/convention only datapoint:
ENV RAPI_PSGI_EXTENDED_STACK_VERSION=psgi-1.3404-a0-02
#
# Standard environment variables:
ENV SHELL="/bin/bash"
ENV USER="root"
# --

#
# Current stack "A0" libs, in no particular order:
#

# Install Debian packages noninteractively.
ARG DEBIAN_FRONTEND=noninteractive

# Install rapi-psgi extras.
RUN rapi-install-extras

# Update apt-get metadata.
RUN apt-get update

# Upgrade existing packages to the latest versions.
RUN apt-get -y upgrade

# Install additional packages of interest.
RUN apt-get -y install \
  colordiff \
  less \
  libterm-readkey-perl \
  man-db \
  postgresql-common \
  strace \
  ripgrep \
&& :

# Setup PostgreSQL apt repository.
RUN echo "" | /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh

# Install latest PostgreSQL client.
RUN apt-get -y install postgresql-client

# packages which fail tests and currently must be force installed:
RUN cpanm --notest --force \
  Furl \
  OAuth2::Google::Plus \
  Plack::App::Proxy \
  Schedule::Cron \
  Term::ReadLine::Perl \
&& rm -rf ~/.cpanm/

# packages which install properly
RUN cpanm \
  Algorithm::CheckDigits \
  aliased \
  Amazon::MWS \
  Amazon::MWS::Client \
  Archive::Zip \
  Benchmark::Timer \
  Carp::Always \
  Catalyst::Plugin::RunAfterRequest \
  Catalyst::Plugin::SimpleCAS \
  CGI::Expand \
  Config::Settings \
  Data::Dump \
  Data::Dx \
  Data::Printer \
  Data::TableReader \
  Data::TableReader::Decoder::HTML \
  Date::RetentionPolicy \
  DateTime \
  DateTime::Format::Duration \
  DateTime::Format::Flexible \
  DateTime::Format::Pg \
  DBD::Pg \
  DBIx::Class::AuditAny \
  DBIx::Class::Candy \
  DBIx::Class::Cursor::Cached \
  DBIx::Class::Helper::Row::SelfResultSet \
  DBIx::Class::Helpers \
  DBIx::Class::QueryLog \
  DBIx::Class::ResultDDL \
  DBIx::Class::Schema::Diff \
  DBIx::Class::StateMigrations \
  DBIx::Class::TimeStamp \
  Devel::Confess \
  Devel::DDCWarn \
  Devel::NYTProf \
  Digest::MD5 \
  Digest::SHA1 \
  Email::Address \
  Email::MIME::CreateHTML \
  Email::Sender \
  Email::Valid \
  HTML::Diff \
  HTML::Entities \
  HTML::FormatText::WithLinks \
  HTML::FromANSI \
  HTML::FromText \
  HTTP::Request \
  HTTP::Request::AsCGI \
  JSON \
  JSON::XS \
  lib::relative \
  Lingua::EN::Nickname \
  Log::Any \
  Log::Any::Adapter::Daemontools \
  Log::Any::Adapter::TAP \
  Log::Contextual::WarnLogger \
  LWP::UserAgent \
  Math::PercentChange \
  Moo \
  Moose \
  MooseX::AttributeShortcuts \
  MooseX::FileAttribute \
  MooseX::SimpleConfig \
  MooseX::Types::LoadableClass \
  MooseX::Types::Moose \
  Net::LDAP \
  Net::Server \
  Package::Stash \
  PadWalker \
  Parallel::ForkManager \
  Path::Class \
  PDF::API2 \
  Plack::Builder \
  Plack::Middleware \
  RapidApp::Util \
  Spreadsheet::ParseExcel \
  Spreadsheet::ParseXLSX \
  Starman \
  String::TT \
  Term::ReadKey \
  Term::ReadLine \
  Term::Size::Any \
  Test::Postgresql58 \
  Text::CSV_XS \
  Text::Password::Pronounceable \
  Text::Trim \
  Tie::FS \
  Tie::Hash::Indexed \
  Try::Tiny \
  Type::Tiny \
  WebService::Mattermost \
  WWW::Scripter \
  YAML \
  YAML::XS \
&& rm -rf ~/.cpanm/

RUN cpanm http://www.cpan.org/authors/id/V/VA/VANSTYN/DBIC-Violator-0.900.tar.gz && rm -rf .cpanm/


## docker-build command refernce:
#
# time docker build -t rapi/psgi-stack-a0 .
# docker tag rapi/psgi-stack-a0 rapi/psgi-stack-a0:psgi-1.3404-a0-02
# docker push rapi/psgi-stack-a0
#

