class Tg < Formula
  desc "Command-line interface for Telegram"
  homepage "https://github.com/kenorb-contrib/tg"
  url "https://github.com/kenorb-contrib/tg.git",
      tag:      "20200106",
      revision: "e63c9ddcf391de7f131c5d0849713b2fe14fef11"
  license "GPL-2.0"
  revision 0
  head "https://github.com/kenorb-contrib/tg.git", branch: "master"


  depends_on "pkg-config" => :build
  depends_on "jansson"
  depends_on "libconfig"
  depends_on "libevent"
  depends_on "openssl@1.1"
  depends_on "readline"

  uses_from_macos "zlib"

  def install
    args = %W[
      --prefix=#{prefix}
      CFLAGS=-I#{Formula["readline"].include}
      CPPFLAGS=-I#{Formula["readline"].include}
      LDFLAGS=-L#{Formula["readline"].lib}
      --disable-liblua
      --sysconfdir=#{etc}
    ]

    system "./configure", *args
    system "make"

    bin.install "bin/telegram-cli" => "telegram"
    bin.install "tg-server.pub" => "server.pub"
  end

  test do
    assert_match "messages_allocated", shell_output("echo stats | #{bin}/telegram")
  end
end

