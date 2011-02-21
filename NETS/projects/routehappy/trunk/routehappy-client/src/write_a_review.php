<!doctype html>  
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html lang="en" class="no-js"><!--<![endif]-->
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>Routehappy: Write a Review</title>
	<meta name="description" content="routehappy">
	<meta name="author" content="routehappy">
	
	<!--  Mobile viewport optimized: j.mp/bplateviewport -->
	<!-- <meta name="viewport" content="width=device-width, initial-scale=1.0"> -->
	
	<!-- Place favicon.ico & apple-touch-icon.png in the root of your domain and delete these references -->
	<link rel="shortcut icon" href="/favicon.ico">
	<link rel="apple-touch-icon" href="/apple-touch-icon.png">
	
	
	<link rel="stylesheet" href="c/global.css?v=1">
	<link rel="stylesheet" href="c/jquery-ui-1.8.9.custom.css?v=1">
	
	
	<!-- All JavaScript at the bottom, except for Modernizr which enables HTML5 elements & feature detects -->
	<script src="j/libs/modernizr-1.6.min.js"></script>

</head>

<body>

  <div id="container">

<!-- Header -->
    <header>
    	<ul class="float-r list-horiz small">
    		<li><a href="#" class="btn b-primary"><span>Sign Up</span></a></li>
    		<li><a href="#" class="btn b-primary"><span>Sign In</span></a></li>
    		<li>
    			<select>
    				<option>English</option>
    			</select>
    		</li>
		</ul>
    	<h3><a href="#">Routehappy</a></h3>
    	<h4>Air Travel Ratings & Reviews to Help You Fly Better</h4>
    </header>
<!-- end Header -->
    
<!-- Global Navigation -->
    <ul id="nav-main" class="list-horiz">
    	<li><a href="#">Home</a></li>
    	<li><a href="#">Routes</a></li>
    	<li><a href="#">Airlines</a></li>
    	<li><a href="#">Airports</a></li>
    	<li class="active"><a href="#">Write a Review</a></li>
    	<li><a href="#">Profile</a></li>
    	<li><a href="#">Mobile</a></li>
    </ul>
<!-- end Global Navigation -->
    
    <div id="main" class="clear">
    	<div class="column span-12 first last">
            <form action="submitJson.php" method="post">
<!-- Breadcrumbs -->
    		<ul id="nav-breadcrumb" class="clear list-horiz tiny">
    			<li class="icn i-next"><a href="#">Home</a></li>
    			<li>Write a Review</li>
    		</ul>
<!-- end Breadcrumbs -->

    		<h1>Rate and Review Your Experience</h1>
    		
    		
    		<div class="why-review">
    			<div class="span-4">
    				<dl>
    					<dt>Why review?</dt>
    					<dd>1. Let airlines know what you think</dd>
    					<dd>2. Help your fellow flyer</dd>
    					<dd>3. Become a route expert</dd>
    					<dd>4. Improve your air travel experience (what goes around, comes around)</dd>
    					<dd>5. It only takes a minute</dd>
    					<dd class="last">Together, we can make flying better</dd>
    				</dl>
    				<img src="i/map.png">
    			</div>
    		</div>
    		
    		<fieldset class="form-step clear">
    			<legend>Step <span>1</span></legend>
    			<h3>What kind of trip do you want to review today?</h3>
    			<ul>
    				<li>
    					<label>&nbsp;</label>
    					<ul class="form-radio list-horiz">
    						<li>
    							<input type="radio" name="trip_type" id="there" value="there"/>
    							<label for="there">The way there</label>
    						</li>
    						<li>
    							<input type="radio" name="trip_type" id="back" value="back"/>
    							<label for="back">The way back</label>
    						</li>
    						<li>
    							<input type="radio" name="trip_type" id="both" value="both"/>
    							<label for="both">Both ways</label>
    						</li>
    					</ul>
    				</li>
    			</ul>
    		</fieldset>
    		
    		

    		
    		<fieldset class="form-step clear">
    			<legend>Step <span>2</span></legend>
    			<h3>Your flight details</h3>
    			<h4>Outbound (the way there)</h4>
    			<ul>
    				<li>
    					<label>Stops</label>
    					<ul class="form-radio list-horiz">
    						<li>
    							<input type="radio" name="stops" id="nonstop" value="non-stop"/>
    							<label for="nonstop">I flew non-stop</label>
    						</li>
    						<li>
    							<input type="radio" name="stops" id="oneway" value="stops"/>
    							<label for="oneway">I made a stop</label>
    						</li>
    					</ul>
    				</li>
    				<li class="division">
    					<small class="quiet">1st Flight</small>
    					<label>Airline</label>
    					<div class="form-text">
                            <span>
                                <input type="text"
                                       value="Which airline did you fly on?"
                                       onFocus="clearText(this)"
                                       onBlur="clearText(this)"
                                       name="legOneAirline"/>
                            </span>
                        </div>
    				</li>
    				<li>
    					<label>From</label>
    					<div class="form-text">
                            <span>
                                <input
                                    type="text"
                                    value="Which airport did you fly from?"
                                    onFocus="clearText(this)"
                                    onBlur="clearText(this)"
                                    name="legOneAirportSource"/>
                            </span>
                        </div>
    				</li>
    				<li>
    					<label>Connection</label>
    					<div class="form-text">
                            <span>
                                <input
                                   type="text"
                                   value="Which airport did you connect in?"
                                   onFocus="clearText(this)"
                                   onBlur="clearText(this)"
                                   name="legOneAirportDest"
                                       />
                            </span>
                        </div>
    				</li>
    				<li>
    					<label>Cabin</label>
    					<select name="cabinSelection">
    						<option>Economy</option>
    						<option>Premium Economy</option>
    						<option>Business</option>
    						<option>First</option>
    					</select>
 						<span class="h2 angelina">Lucky you!</span>

    				</li>

    				<li class="division">
    					<label class="tight">Date</label>
    					<div class="form-text date">
                            <span>
                            <input
                                type="text"
                                id="datepicker"
                                name="flightDate"
                                value="mm/dd/yyyy"
                                onFocus="clearText(this)"
                                onBlur="clearText(this)"/>
                        </span>
                        </div>
    				</li>
    				<li>
    					<label class="tight">Reason</label>
    					<ul class="form-radio list-horiz">
    						<li>
    							<input type="radio" name="reason" id="personal" value="personal"/>
    							<label for="personal">Personal</label>
    						</li>
    						<li>
    							<input type="radio" name="reason" id="business" value="business"/>
    							<label for="business">Business</label>
    						</li>
    						<li>
    							<input type="radio" name="reason" id="reasonboth" value="both"/>
    							<label for="reasonboth">Both</label>
    						</li>
    					</ul>
    				</li>
    				<li>
    					<label class="tight">With</label>
    					<ul class="form-radio list-horiz">
    						<li>
    							<input type="radio" name="partyCode" id="infants" value="infants"/>
    							<label for="infants">Infant(s)</label>
    						</li>
    						<li>
    							<input type="radio" name="partyCode" id="kids" value="kids"/>
    							<label for="kids">Kid(s)</label>
    						</li>
    						<li>
    							<input type="radio" name="partyCode" id="kidsboth" value="both"/>
    							<label for="kidsboth">Both</label>
    						</li>
    						<li>
    							<input type="radio" name="partyCode" id="neither" checked value="neither"/>
    							<label for="neither">Neither</label>
    						</li>
    					</ul>
    				</li>
    			</ul>
    		</fieldset>

    		
    		<fieldset class="form-submit clear-alt">
    			<p class="float-r tiny quiet">By clicking the orange button you<br/>agree to our <a href="#">terms</a> and <a href="#">policies</a>.</p>
    			<input type="submit"  value="Submit" class="float-r"/>
    			<p class="tiny float-r" style="line-height:40px;margin:0;"><a href="#">Preview</a></p>
    		</fieldset>
    		
    		</form>
    	</div>
    </div>
    
    <footer class="small">
    	<ul class="float-r list-horiz">
    		<li><a href="#">About Us</a></li>
    		<li><a href="#">Site Map</a></li>
    		<li><a href="#">Blog</a></li>
    		<li><a href="#">Help</a></li>
    		<li><a href="#">Contact</a></li>
    		<li><a href="#">Partners</a></li>
    		<li><a href="#">Mobile</a></li>
    		<li>Join Us <a href="#">Twitter</a> & <a href="#">Facebook</a></li>
    		<li><a href="#">Terms</a></li>
    		<li><a href="#">Privacy</a></li>
    	</ul>
    	&copy; 2011 Routehappy

    </footer>
  </div> <!--! end of #container -->


  <!-- Javascript at the bottom for fast page loading -->

  <!-- Grab Google CDN's jQuery. fall back to local if necessary -->
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js"></script>
  <script>!window.jQuery && document.write(unescape('%3Cscript src="j/libs/jquery-1.4.2.js"%3E%3C/script%3E'))</script>
  <script src="j/jquery-ui-1.8.9.custom.min.js"></script>
  <script>
	$(function() {
		$( "#datepicker" ).datepicker();
	});
	
	function clearText(field)
{
	if (field.defaultValue == field.value) {
	
		field.value = '';
		field.style.color = '#000000';
		
	} else if (field.value == '') {
	
		field.value = field.defaultValue;
		field.style.color = '#919294';
	}
}
	</script>
  
  
  <!-- scripts concatenated and minified via ant build script
  <script src="js/plugins.js"></script>
  <script src="js/script.js"></script>
  end concatenated and minified scripts-->
  
  
  <!--[if lt IE 7 ]>
    <script src="j/libs/dd_belatedpng.js"></script>
    <script> DD_belatedPNG.fix('img, .png_bg'); //fix any <img> or .png_bg background-images </script>
  <![endif]-->

  <!-- asynchronous google analytics: mathiasbynens.be/notes/async-analytics-snippet 
       change the UA-XXXXX-X to be your site's ID
  <script>
   var _gaq = [['_setAccount', 'UA-XXXXX-X'], ['_trackPageview']];
   (function(d, t) {
    var g = d.createElement(t),
        s = d.getElementsByTagName(t)[0];
    g.async = true;
    g.src = ('https:' == location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    s.parentNode.insertBefore(g, s);
   })(document, 'script');
  </script> -->
  
</body>
</html>