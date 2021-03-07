FROM rapi/psgi:1.3400
MAINTAINER Henry Van Styn <vanstyn@cpan.org>

# --
# rapi/psgi "stack" version is psgi-1.3400-a0-00:
#
#   psgi-1.3400 : based on rapi/psgi:1.3400
#   a0          : this docker image is named "rapi/psgi-stack-a0"
#   00          : sub version 00
#
# This is an informational/convention only datapoint:
ENV RAPI_PSGI_EXTENDED_STACK_VERSION=psgi-1.3400-a0-00
# --


# Current stack "A0" libs, in no particular order:
RUN cpanm \
  Archive::Zip \
  aliased \
  Benchmark::Timer \
  Carp::Always \
  CGI::Expand \
  Config::Settings \
  DateTime \
  DateTime::Format::Duration \
  DateTime::Format::Flexible \
  DateTime::Format::Pg \
  DBD::Pg \
  DBIx::Class::Candy \
  DBIx::Class::Cursor::Cached \
  DBIx::Class::Helper::Row::SelfResultSet \
  DBIx::Class::Helpers \
  DBIx::Class::QueryLog \
  DBIx::Class::ResultDDL \
  DBIx::Class::TimeStamp \
  DBIx::Class::AuditAny \
  DBIx::Class::Helpers \
  DBIx::Class::Schema::Diff \
  DBIx::Class::StateMigrations \
  DBIx::Class::TimeStamp \
  Devel::Confess \
  Devel::DDCWarn \
  HTTP::Request \
  HTTP::Request::AsCGI \
  JSON \
  lib::relative \
  Lingua::EN::Nickname \
  Log::Any \
  Log::Contextual::WarnLogger \
  Math::PercentChange \
  Moose \
  MooseX::AttributeShortcuts \
  MooseX::Types::LoadableClass \
  MooseX::Types::Moose \
  Net::LDAP \
  Package::Stash \
  PadWalker \
  Parallel::ForkManager \
  Path::Class \
  Plack::Middleware \
  RapidApp::Util \
  String::TT \
  Text::Trim \
  Tie::Hash::Indexed \
  Text::Trim \
  Type::Tiny \
  YAML \
  HTML::Diff \
  Amazon::MWS \
  Amazon::MWS::Client \
  Catalyst::Plugin::RunAfterRequest \
  Data::Dump \
  Data::Dx \
  Data::Printer \
  Data::TableReader \
  DateTime::Format::Flexible \
  Devel::NYTProf \
  Digest::SHA1 \
  Email::Address \
  Email::MIME::CreateHTML \
  Email::Sender \
  HTML::Diff \
  HTML::Entities \
  HTML::FormatText::WithLinks \
  HTML::FromANSI \
  JSON::XS \
  LWP::UserAgent \
  Log::Any \
  Log::Any::Adapter::Daemontools \
  Log::Any::Adapter::TAP \
  Plack::Builder \
  Spreadsheet::ParseExcel \
  Spreadsheet::ParseXLSX \
  Starman \
  Term::ReadLine \
  Term::Size::Any \
  Text::CSV_XS \
  Text::Trim \
  Tie::Hash::Indexed \
  Try::Tiny \
  WebService::Mattermost \
  YAML::XS \
&& rm -rf .cpanm/
