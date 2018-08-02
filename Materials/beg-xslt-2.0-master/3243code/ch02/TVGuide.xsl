<?xml version="1.0" encoding="ISO-8859-1"?>
<html xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
      xsl:version="2.0">
<head>
  <title>TV Guide</title>
  <link rel="stylesheet" href="TVGuide.css" />
  <script type="text/javascript">
    function toggle(element) {
      if (element.style.display == 'none') {
        element.style.display = 'block';
      } else {
        element.style.display = 'none';
      }
    }
  </script>
</head>

<body>
  <h1>TV Guide</h1>

  <h2 class="channel">BBC1</h2>
  <div>
    <p>
      <span class="date">2001-07-05T19:00:00</span><br />
      <span class="title">A Question Of Sport</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T19:30:00</span><br />
      <span class="title">EastEnders</span><br />
      Mark's health scare forces him to reconsider his future with Lisa,
      while Jamie is torn between Sonia and Zoe.
      <span onclick="toggle(EastEndersCast);">[Cast]</span>
    </p>
    <div id="EastEndersCast" style="display: none;">
      <ul class="castlist">
        <li>
          <span class="character">Zoe Slater</span>
          <span class="actor">Michelle Ryan</span>
        <li>
          <span class="character">Jamie Mitchell</span>
          <span class="actor">Jack Ryder</span>
        <li>
          <span class="character">Sonia Jackson</span>
          <span class="actor">Natalie Cassidy</span>
      </ul>
    </div>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T20:00:00</span><br />
      <span class="title">Get Real with Casualty</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T20:45:00</span><br />
      <span class="title">The National Lottery</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T21:30:00</span><br />
      <span class="title">Panorama</span><br />
    </p>
  </div>  

  <h2 class="channel">BBC2</h2>
  <div>
    <p>
      <span class="date">2001-07-05T19:00:00</span><br />
      <span class="title">Snooker</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T20:00:00</span><br />
      <span class="title">Home Front</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T21:00:00</span><br />
      <span class="title">Wild Africa</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T21:50:00</span><br />
      <span class="title">Taboo <span class="subtitle">Nakedness</span></span><br />
    </p>
  </div>
  
  <h2 class="channel">ITV</h2>
  <div>
    <p>
      <span class="date">2001-07-05T19:00:00</span><br />
      <span class="title">Emmerdale</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T19:30:00</span><br />
      <span class="title">Coronation Street</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T20:00:00</span><br />
      <span class="title">Who Wants to Be a Millionaire?</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T21:00:00</span><br />
      <span class="title">Hot Money</span><br />
    </p>
  </div>
  
  <h2 class="channel">Channel 4</h2>
  <div>
    <p>
      <span class="date">2001-07-05T19:00:00</span><br />
      <span class="title">Channel 4 News</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T19:55:00</span><br />
      <span class="title">Slot Art</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T20:00:00</span><br />
      <span class="title">Brookside</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T20:30:00</span><br />
      <span class="title">Brookside</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T21:00:00</span><br />
      <span class="title">Swallow</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T22:00:00</span><br />
      <span class="title">Ally McBeal</span><br />
    </p>
  </div>
  
  <h2 class="channel">Channel 5</h2>
  <div>
    <p>
      <span class="date">2001-07-05T19:00:00</span><br />
      <span class="title">The Movie Chart Show</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T19:30:00</span><br />
      <span class="title">5 News</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T20:00:00</span><br />
      <span class="title">The World's Worst Drivers Caught On Tape</span><br />
    </p>
  </div>
  <div>
    <p>
      <span class="date">2001-07-05T21:00:00</span><br />
      <span class="title">Black and White</span><br />
    </p>
  </div>
</body>
</html>