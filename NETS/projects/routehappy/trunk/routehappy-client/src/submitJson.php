<?php

    function getCabinCode( $cabinCodeName )
    {

        switch( $cabinCodeName )
        {
            case "Economy":
                return 0;
            case "Premium Economy":
                return 1;
            case "Business":
                return 2;
            case "First":
                return 3;
        }

    }


    function getOutBoundReturnCode( $tripType )
    {
        switch( $tripType )
        {
            case "there":
                return 1;
            case "back":
                return 2;
            default:
                return 1;

        }
    }

    function getNumStops( $nonStopOrStop )
    {
        $numStops = 0;
        switch( $nonStopOrStop )
        {
            case "non-stop":
                $numStops = 1;
                break;
            case "stops":
                $numStops = 2;
                break;
        }
        return $numStops;
    }

    function getTripDate( $tripDate )
    {
        $date = DateTime::createFromFormat('m/d/Y', $tripDate);
        return $date->format('c');
    }

    function curl_post($url, array $post = NULL, array $options = array())
    {

        error_log("test");

        $defaults = array(
            CURLOPT_POST => 1,
            CURLOPT_HEADER => 0,
            CURLOPT_URL => $url,
            CURLOPT_FRESH_CONNECT => 1,
            CURLOPT_RETURNTRANSFER => 1,
            CURLOPT_FORBID_REUSE => 1,
            CURLOPT_TIMEOUT => 4,
            CURLOPT_POSTFIELDS => $post[0]
        );

        $ch = curl_init();

        error_log("initialize curl");

        curl_setopt_array($ch, ($options + $defaults));
        curl_setopt($ch,CURLOPT_HTTPHEADER,array (
            "Content-Type: application/json; charset=utf-8"));
        if( ! $result = curl_exec($ch))
        {
            trigger_error(curl_error($ch));
            error_log("failed");
        }

        error_log("make call complete");

        curl_close($ch);
        return $result;
    }

    $optionalRatings = array(
         "departureGettingToAirport" => $HTTP_POST_VARS['departureGettingToAirport']
         ,"departureCheckinSecurity" => $HTTP_POST_VARS['departureCheckinSecurity']
         ,"departureAirportFoodShop" => $HTTP_POST_VARS['departureAirportFoodShop']
         ,"departureGateAndBoarding" => $HTTP_POST_VARS['departureGateAndBoarding']
         ,"airportLoung" => $HTTP_POST_VARS['airportLoung']
         ,"firstFlightAirplainComfort" => $HTTP_POST_VARS['firstFlightAirplainComfort']
         ,"firstFlightCleanliness" => $HTTP_POST_VARS['firstFlightCleanliness']
         ,"firstFlightCabinCrew" => $HTTP_POST_VARS['firstFlightCabinCrew']
         ,"firstFlightFood" => $HTTP_POST_VARS['firstFlightFood']
         ,"firstFlightEntertainment" => $HTTP_POST_VARS['firstFlightEntertainment']
         ,"arrivalGettingOffPlane" => $HTTP_POST_VARS['arrivalGettingOffPlane']
         ,"arrivalBaggageClaim" => $HTTP_POST_VARS['arrivalBaggageClaim']
         ,"arrivalBaggageHandling" => $HTTP_POST_VARS['arrivalBaggageHandling']
         ,"arrivalImmigrationCustoms" => $HTTP_POST_VARS['arrivalImmigrationCustoms']
         ,"leavingAirport" => $HTTP_POST_VARS['leavingAirport']
    );

    $airPortSource = array(
        "constructedName"=> $HTTP_POST_VARS['legOneAirportSource'],
        "name"=> $HTTP_POST_VARS['legOneAirportSource']
    );

    $airPortDest = array(
        "constructedName"=> $HTTP_POST_VARS['legOneAirportDest'],
        "name"=> $HTTP_POST_VARS['legOneAirportSource']
    );

    $airLine = array(
        "airlineName" => $HTTP_POST_VARS['legOneAirline']
        ,"displayedName" => $HTTP_POST_VARS['legOneAirline']
    );

    $segment1 = array(
        "cabinCode" => getCabinCode($HTTP_POST_VARS['cabinSelection']),
        "rating" => $HTTP_POST_VARS['ratings-airline'],
        "ratingAirportDest" => $HTTP_POST_VARS['ratings-arrival'],
        "ratingAirportOrig" => $HTTP_POST_VARS['ratings-departure'],
        "segment" => "1",
        "tripDate" => getTripDate($HTTP_POST_VARS['flightDate']),
        "airline" => $airLine,
        "airportOrig" => $airPortSource,
        "airportDest" => $airPortDest
    );

    $review = array(
        "numberStops"=> getNumStops($HTTP_POST_VARS['stops'])
        ,"outboundReturnCode" => getOutBoundReturnCode($HTTP_POST_VARS['trip_type'])
        ,"tripDate" => getTripDate($HTTP_POST_VARS['flightDate'])
        ,"segments" => array($segment1)
        ,"optionalRatings" => $optionalRatings
    );

    $trip = array(
        "partyCode" => $HTTP_POST_VARS['partyCode']
        ,"reason" => $HTTP_POST_VARS['reason']
        ,"reviews" => $review
        ,"description" => $HTTP_POST_VARS['trip_type']
    );

    $json = json_encode($trip);
    $result = curl_post("http://localhost:8080/nets/expense/services/rh/saveReview", array($json));

    echo $json . "<br><br><br>";
    echo $result;
?>