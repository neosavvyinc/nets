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
    							<input type="radio" name="trip_type" id="both" value="both" disabled="true"/>
    							<label for="both">Both ways</label>
    						</li>
    					</ul>
    				</li>
    			</ul>
    		</fieldset>
    		
    		

    		
    		<fieldset class="form-step clear">
    			<legend>Step <span>2</span></legend>
    			<h3>Your flight details</h3>
    			<ul>
    				<li>
    					<label>Stops</label>
    					<ul class="form-radio list-horiz">
    						<li>
    							<input type="radio" name="stops" id="nonstop" value="non-stop" checked="true"/>
    							<label for="nonstop">I flew non-stop</label>
    						</li>
    						<li>
    							<input type="radio" name="stops" id="oneway" value="stops" disabled="true"/>
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
    					<label>To</label>
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

            <fieldset class="form-step clear">
    			<legend>Step <span>3</span></legend>
    			<h3>Your ratings <span>Rate from <em class="icn i-con">1 Terrible</em> to <em class="icn i-pro">10 Excellent</em></span></h3>
    			<ul>
    				<li>
    					<label>1st Flight</label>
    					<ul class="form-ratings list-horiz">
    						<li class="first">
    							<input type="radio" name="ratings-airline" id="airlinerat1" value="1"/>
    							<label for="airlinerat1">1</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat2" value="2"/>
    							<label for="airlinerat23">2</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat3" value="3"/>
    							<label for="airlinerat">3</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat4" value="4"/>
    							<label for="airlinerat4">4</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat5" value="5"/>
    							<label for="airlinerat5">5</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat6" value="6"/>
    							<label for="airlinerat6">6</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat7" value="7"/>
    							<label for="airlinerat7">7</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat8" value="8"/>
    							<label for="airlinerat8">8</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-airline" id="airlinerat9" value="9"/>
    							<label for="airlinerat9">9</label>
    						</li>
    						<li class="last">
    							<input type="radio" name="ratings-airline" id="airlinerat10" value="10"/>
    							<label for="airlinerat10">10</label>
    						</li>
    					</ul>
    				</li>
<!--    				<li>-->
<!--    					<label>2nd Flight</label>-->
<!--    					<ul class="form-ratings list-horiz">-->
<!--    						<li class="first">-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat1"/>-->
<!--    							<label for="airline2rat1">1</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat2"/>-->
<!--    							<label for="airline2rat2">2</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat3"/>-->
<!--    							<label for="airline2rat3">3</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat4"/>-->
<!--    							<label for="airline2rat4">4</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat5"/>-->
<!--    							<label for="airline2rat5">5</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat6"/>-->
<!--    							<label for="airline2rat6">6</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat7"/>-->
<!--    							<label for="airline2rat7">7</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat8"/>-->
<!--    							<label for="airline2rat8">8</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat9"/>-->
<!--    							<label for="airline2rat9">9</label>-->
<!--    						</li>-->
<!--    						<li class="last">-->
<!--    							<input type="radio" name="ratings-airline2" id="airline2rat10"/>-->
<!--    							<label for="airline2rat10">10</label>-->
<!--    						</li>-->
<!--    					</ul>-->
<!--    				</li>-->
    				<li>
    					<label>Departure Airport</label>
    					<ul class="form-ratings list-horiz">
    						<li class="first">
    							<input type="radio" name="ratings-departure" id="departurerat1" value="1"/>
    							<label for="departurerat1">1</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat2" value="2"/>
    							<label for="departurerat23">2</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat3" value="3"/>
    							<label for="departurerat">3</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat4" value="4"/>
    							<label for="departurerat4">4</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat5" value="5"/>
    							<label for="departurerat5">5</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat6" value="6"/>
    							<label for="departurerat6">6</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat7" value="7"/>
    							<label for="departurerat7">7</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat8" value="8"/>
    							<label for="departurerat8">8</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-departure" id="departurerat9" value="9"/>
    							<label for="departurerat9">9</label>
    						</li>
    						<li class="last">
    							<input type="radio" name="ratings-departure" id="departurerat10" value="10"/>
    							<label for="departurerat10">10</label>
    						</li>
    					</ul>
    				</li>
<!--    				<li>-->
<!--    					<label>Connection Airport</label>-->
<!--    					<ul class="form-ratings list-horiz">-->
<!--    						<li class="first">-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat1"/>-->
<!--    							<label for="connectionrat1">1</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat2"/>-->
<!--    							<label for="connectionrat23">2</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat3"/>-->
<!--    							<label for="connectionrat">3</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat4"/>-->
<!--    							<label for="connectionrat4">4</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat5"/>-->
<!--    							<label for="connectionrat5">5</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat6"/>-->
<!--    							<label for="connectionrat6">6</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat7"/>-->
<!--    							<label for="connectionrat7">7</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat8"/>-->
<!--    							<label for="connectionrat8">8</label>-->
<!--    						</li>-->
<!--    						<li>-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat9"/>-->
<!--    							<label for="connectionrat9">9</label>-->
<!--    						</li>-->
<!--    						<li class="last">-->
<!--    							<input type="radio" name="ratings-connection" id="connectionrat10"/>-->
<!--    							<label for="connectionrat10">10</label>-->
<!--    						</li>-->
<!--    					</ul>-->
<!--    				</li>-->
    				<li>
    					<label>Arrival Airport</label>
    					<ul class="form-ratings list-horiz last">
    						<li class="first">
    							<input type="radio" name="ratings-arrival" id="arrivalrat1" value="1"/>
    							<label for="arrivalrat1">1</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat2" value="2"/>
    							<label for="arrivalrat23">2</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat3" value="3"/>
    							<label for="arrivalrat">3</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat4" value="4"/>
    							<label for="arrivalrat4">4</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat5" value="5"/>
    							<label for="arrivalrat5">5</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat6" value="6"/>
    							<label for="arrivalrat6">6</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat7" value="7"/>
    							<label for="arrivalrat7">7</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat8" value="8"/>
    							<label for="arrivalrat8">8</label>
    						</li>
    						<li>
    							<input type="radio" name="ratings-arrival" id="arrivalrat9" value="9"/>
    							<label for="arrivalrat9">9</label>
    						</li>
    						<li class="last">
    							<input type="radio" name="ratings-arrival" id="arrivalrat10" value="10"/>
    							<label for="arrivalrat10">10</label>
    						</li>
    					</ul>
    				</li>


    				<li class="form-options" id="optionalFormItems">
    					<a href="#" onclick="" class="float-r small">Hide</a>
    					<h3>Optional <span>Rate as many categories as you want from <em>1 Terrible</em> to <em>10 Excellent</em></h3>
    					<dl class="option-set tiny">
    						<dt>Departure</dt>
    						<dd>
    							<input type="text" class="float-r" name="departureGettingToAirport">
    							Getting to the airport
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="departureCheckinSecurity">
    							Check in and security
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="departureAirportFoodShop">
    							Airport food & shop
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="departureGateAndBoarding">
    							Gate & boarding
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="airportLoung">
    							Private airport lounge
    						</dd>
    					</dl>
    					<dl class="option-set tiny">
    						<dt>On Flight</dt>
    						<dd>
    							<input type="text" class="float-r" name="firstFlightAirplainComfort">
    							Airplane comfort
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="firstFlightCleanliness">
    							Airplane cleanliness
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="firstFlightCabinCrew">
    							Cabin crew
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="firstFlightFood">
    							Food
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="firstFlightEntertainment">
    							Entertainment
    						</dd>
    					</dl>
<!--    					<dl class="option-set tiny">-->
<!--    						<dt>Connecting airport</dt>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Getting to the gate-->
<!--    						</dd>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Airport food & shops-->
<!--    						</dd>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Gate & boarding-->
<!--    						</dd>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Private airport lounge-->
<!--    						</dd>-->
<!--    					</dl>-->
<!--    					<dl class="option-set tiny">-->
<!--    						<dt>On 2nd Flight</dt>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Airplane comfort-->
<!--    						</dd>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Airplane cleanliness-->
<!--    						</dd>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Cabin crew-->
<!--    						</dd>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Food-->
<!--    						</dd>-->
<!--    						<dd>-->
<!--    							<input type="text" class="float-r">-->
<!--    							Entertainment-->
<!--    						</dd>-->
<!--    					</dl>-->
    					<dl class="option-set tiny last">
    						<dt>Arrival</dt>
    						<dd>
    							<input type="text" class="float-r" name="arrivalGettingOffPlane">
    							Getting off plane
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="arrivalBaggageClaim">
    							Getting to baggage claim
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="arrivalBaggageHandling">
    							Getting/handling baggage
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="arrivalImmigrationCustoms">
    							Immigration & customs
    						</dd>
    						<dd>
    							<input type="text" class="float-r" name="leavingAirport">
    							Leaving the airport
    						</dd>
    					</dl>
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