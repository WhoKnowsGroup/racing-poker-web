<!-- this page serves as a template for setting up new pages with the V2 UI styles -->
<%@ page isELIgnored="false" %>
<%@ taglib tagdir='/WEB-INF/tags' prefix='rp' %>
<%@ taglib tagdir='/WEB-INF/tags/v2' prefix='v2' %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en-us">
	<head>
        <title>Racing Poker | Online Poker</title>
        <meta charset='utf-8'>
        <meta name='viewport' content='width=device-width, initial-scale=1'>
        <meta name='keywords' content='Poker,racing poker,online poker,poker tournaments,players'>
        <meta name='application-name' content='Racing Poker'>
        <meta name='author' content='Pokerace Team'>
        <link rel='icon' href='/images/racingpoker-logo9.png' />
        <link rel='stylesheet' href='/css/bootstrap_min.css' />
        <link rel='stylesheet' href='/templates/PageStyleSheets.css' />
        <link rel='stylesheet' href='/templates/PageLayout.css' />
        <link rel='stylesheet' type='text/css' href='/css/highslide.css' />
        <v2:basicHeader />
        <v2:gameplayStyles />
        <v2:commonScripts />   
        <style>
        	.page-wrapper {
        		overflow: hidden;
        	}
        	.footer {
        		height: auto;
        	}
        	.headerStats {
        		display: inline-block;
			    position: relative;
			    top: 44px;
			    left: 44px;
        	}
        	.simple-table tr th {
			    text-align: center;
			}
			#tab-1 .profile-img {
			    position: relative;
			    top: -10px;
			    left: 15px;
			}
			.form-profile-rewrite {
			    width: 400px;    
			}
			.form-profile-rewrite .row {
			    width: 390px;
			}
			.form-profile-rewrite label {
			    font-weight: normal;
			}
			.submitRow .btn {
				color: white !important;
			    margin-left: auto;
			    margin-right: auto;
			    display: block;
			    width: 250px;
			    position: relative;
			}
			.profile .main .tabs-body-tab {
				min-height: 600px !important;
			}
        </style>
        <script src='/Jquery/bootstrap_min.js'></script>           
	</head>
	<body>
		<!-- page wrapper -->
        <div class="page-wrapper">
            <v2:preloginNav />

            <!-- main -->
            <main class="main clearfix">
            	<div class="main-inner col-10 offset-1">

                <h1 class="title">Profile</h1>

                    <!-- tabs -->
                    <div class="tabs clearfix">
                        <div class="tabs-nav">
                            <p class="js-tabs-tab nav-tab-active" data-tab-active="1"><img src="/images/v2/user-icon.png" alt="user-icon image"></p>
                            <p class="js-tabs-tab" data-tab-active="2"><img src="/images/v2/coin-icon.png" alt="coin-icon image"></p>
                            <p class="js-tabs-tab" data-tab-active="3"><img src="/images/v2/compass-icon.png" alt="compass-icon image"></p>
                            <p class="js-tabs-tab" data-tab-active="4"><img src="/images/v2/trophy-icon.png" alt="trophy-icon image"></p>
                        </div>
                        <hr>
                        <div class="tabs-body">
                            <div id="tab-1" class="tabs-tab tabs-body-tab custom-scroll">
								<table class="description-box">
                                    <tr>
                                        <!--<td><b>Current Chips</b></td>-->
                                        <td>Chips: <span class="spec-color">${ user.creditsFormatted }</span></td>
                                        <td>Gold: <span class="spec-color">${ user.bitletsIntFormatted }</span></td>
                                        <td>Level: <span class="spec-color">${ user.levelName }</span></td>
                                        <td><a href="/u/addChips" class="btn btn-orange">Get Chips</a></td>
                                    </tr>
                                </table>
                                <div class="profile-info clearfix">
                                	<a href="https://en.gravatar.com/connect/" target="_blank">
                                    	<img class="profile-img" src="${ user.avatarUrl }" alt="Profile photo (click to change)" title="Profile photo (click to change)">
                                    </a>
                                    <form action="/u/updateProfileV2" class="form-profile-rewrite" method="POST">
                                    	<div class="row" style="display: none;">
                                            <label for="first-name-rewrite" class="col-4">Email</label>
                                            <input type="text" name="email" id="email-name-rewrite" class="col-8" placeholder="Email Address" readonly="readonly" value="${ user.email }">
                                        </div>
                                        <div class="row">
                                            <label for="first-name-rewrite" class="col-4">First Name</label>
                                            <input type="text" name="firstname" id="first-name-rewrite" class="col-8" placeholder="First Name" value="${ user.firstName }">
                                        </div>
                                        <div class="row">
                                            <label for="last-name-rewrite" class="col-4">Last Name</label>
                                            <input type="text" name="lastname" id="last-name-rewrite" class="col-8" placeholder="Last Name" value="${ user.lastName }">
                                        </div>
                                        <div class="row">
                                            <label for="screen-name-rewrite" class="col-4">Screen Name</label>
                                            <input type="text" name="nickname" id="screen-name-rewrite" class="col-8" placeholder="Screen Name" value="${ user.nickname }">
                                        </div>
                                        <div class="row genderRow">
                                            <label for="gender-rewrite" class="col-4">Gender</label>
                                            <div class="select-holder col-8">
                                                <select name="gender" id="gender-rewrite" class="custom-select" data-placeholder-option="true">
                                                    <option value="-1">Gender</option>
                                                    <option value="female">Female</option>
                                                    <option value="male">Male</option>
                                                    <option value="other">Other</option>
                                                </select>
                                            </div>
                                        </div>
                                        <c:if test="${ ! empty user.selectedAgeGroup && user.selectedAgeGroup != 'null' && user.yearOfBirth lt 1 }">
	                                        <div class="row ageRow">
	                                            <label for="age-rewrite" class="col-4">Age</label>
	                                            <div class="select-holder col-8">
	                                                <select name="age" id="age-rewrite" class="custom-select" data-placeholder-option="true">
	                                                    <option value="-1">Age Group</option>
						                                <option value="first">18-24</option> 
								           				<option value="second">25-35</option>
						                           		<option value="third">35-49</option>
						                           		<option value="fourth">50-64</option>
						                           		<option value="fifth">> 65</option>
	                                                </select>
	                                            </div>
	                                        </div>
                                        </c:if>
                                        <div class="row ageRow">
                                            <label for="birthYear" class="col-4">Year of Birth</label>
                                            <div class="select-holder col-8">
                                                <select name="birthYear" id="birthYear" class="custom-select" data-placeholder-option="true">
                                                    <option value="-1">Choose a Year</option>
                                                </select>
                                                <script>
	                                                var birthYear = -1;
	                                				<c:if test="${ user.yearOfBirth gt 0 }">
	                                					birthYear = ${ user.yearOfBirth };
	                                				</c:if>
	                                				var currentYear = new Date().getYear() + 1900;
	                                				for (var year = currentYear; year >= 1900; year--) {
	                                					if (year == birthYear) {
	                                						$("#birthYear").append("<option selected='true' value='" + year + "'>" + year + "</option>");
	                                					}
	                                					else {
	                                						$("#birthYear").append("<option value='" + year + "'>" + year + "</option>");
	                                					}
	                                				}
	                                				$("#birthYear").val(birthYear);
                                                </script>
                                            </div>
                                        </div>
                                        <!-- 
                                        <div class="row">
                                            <label for="country-rewrite" class="col-4">Country</label>
                                            <div class="select-holder col-8">
                                                <select name="country-rewrite" id="country-rewrite" class="custom-select" data-placeholder-option="true">
                                                    <option value="female">Country</option>
                                                    <option value="AFG">Afghanistan</option>
                                                    <option value="ALA">Åland Islands</option>
                                                    <option value="ALB">Albania</option>
                                                    <option value="DZA">Algeria</option>
                                                    <option value="ASM">American Samoa</option>
                                                    <option value="AND">Andorra</option>
                                                    <option value="AGO">Angola</option>
                                                    <option value="AIA">Anguilla</option>
                                                    <option value="ATA">Antarctica</option>
                                                    <option value="ATG">Antigua and Barbuda</option>
                                                    <option value="ARG">Argentina</option>
                                                    <option value="ARM">Armenia</option>
                                                    <option value="ABW">Aruba</option>
                                                    <option value="AUS">Australia</option>
                                                    <option value="AUT">Austria</option>
                                                    <option value="AZE">Azerbaijan</option>
                                                    <option value="BHS">Bahamas</option>
                                                    <option value="BHR">Bahrain</option>
                                                    <option value="BGD">Bangladesh</option>
                                                    <option value="BRB">Barbados</option>
                                                    <option value="BLR">Belarus</option>
                                                    <option value="BEL">Belgium</option>
                                                    <option value="BLZ">Belize</option>
                                                    <option value="BEN">Benin</option>
                                                    <option value="BMU">Bermuda</option>
                                                    <option value="BTN">Bhutan</option>
                                                    <option value="BOL">Bolivia, Plurinational State of</option>
                                                    <option value="BES">Bonaire, Sint Eustatius and Saba</option>
                                                    <option value="BIH">Bosnia and Herzegovina</option>
                                                    <option value="BWA">Botswana</option>
                                                    <option value="BVT">Bouvet Island</option>
                                                    <option value="BRA">Brazil</option>
                                                    <option value="IOT">British Indian Ocean Territory</option>
                                                    <option value="BRN">Brunei Darussalam</option>
                                                    <option value="BGR">Bulgaria</option>
                                                    <option value="BFA">Burkina Faso</option>
                                                    <option value="BDI">Burundi</option>
                                                    <option value="KHM">Cambodia</option>
                                                    <option value="CMR">Cameroon</option>
                                                    <option value="CAN">Canada</option>
                                                    <option value="CPV">Cape Verde</option>
                                                    <option value="CYM">Cayman Islands</option>
                                                    <option value="CAF">Central African Republic</option>
                                                    <option value="TCD">Chad</option>
                                                    <option value="CHL">Chile</option>
                                                    <option value="CHN">China</option>
                                                    <option value="CXR">Christmas Island</option>
                                                    <option value="CCK">Cocos (Keeling) Islands</option>
                                                    <option value="COL">Colombia</option>
                                                    <option value="COM">Comoros</option>
                                                    <option value="COG">Congo</option>
                                                    <option value="COD">Congo, the Democratic Republic of the</option>
                                                    <option value="COK">Cook Islands</option>
                                                    <option value="CRI">Costa Rica</option>
                                                    <option value="CIV">Côte d'Ivoire</option>
                                                    <option value="HRV">Croatia</option>
                                                    <option value="CUB">Cuba</option>
                                                    <option value="CUW">Curaçao</option>
                                                    <option value="CYP">Cyprus</option>
                                                    <option value="CZE">Czech Republic</option>
                                                    <option value="DNK">Denmark</option>
                                                    <option value="DJI">Djibouti</option>
                                                    <option value="DMA">Dominica</option>
                                                    <option value="DOM">Dominican Republic</option>
                                                    <option value="ECU">Ecuador</option>
                                                    <option value="EGY">Egypt</option>
                                                    <option value="SLV">El Salvador</option>
                                                    <option value="GNQ">Equatorial Guinea</option>
                                                    <option value="ERI">Eritrea</option>
                                                    <option value="EST">Estonia</option>
                                                    <option value="ETH">Ethiopia</option>
                                                    <option value="FLK">Falkland Islands (Malvinas)</option>
                                                    <option value="FRO">Faroe Islands</option>
                                                    <option value="FJI">Fiji</option>
                                                    <option value="FIN">Finland</option>
                                                    <option value="FRA">France</option>
                                                    <option value="GUF">French Guiana</option>
                                                    <option value="PYF">French Polynesia</option>
                                                    <option value="ATF">French Southern Territories</option>
                                                    <option value="GAB">Gabon</option>
                                                    <option value="GMB">Gambia</option>
                                                    <option value="GEO">Georgia</option>
                                                    <option value="DEU">Germany</option>
                                                    <option value="GHA">Ghana</option>
                                                    <option value="GIB">Gibraltar</option>
                                                    <option value="GRC">Greece</option>
                                                    <option value="GRL">Greenland</option>
                                                    <option value="GRD">Grenada</option>
                                                    <option value="GLP">Guadeloupe</option>
                                                    <option value="GUM">Guam</option>
                                                    <option value="GTM">Guatemala</option>
                                                    <option value="GGY">Guernsey</option>
                                                    <option value="GIN">Guinea</option>
                                                    <option value="GNB">Guinea-Bissau</option>
                                                    <option value="GUY">Guyana</option>
                                                    <option value="HTI">Haiti</option>
                                                    <option value="HMD">Heard Island and McDonald Islands</option>
                                                    <option value="VAT">Holy See (Vatican City State)</option>
                                                    <option value="HND">Honduras</option>
                                                    <option value="HKG">Hong Kong</option>
                                                    <option value="HUN">Hungary</option>
                                                    <option value="ISL">Iceland</option>
                                                    <option value="IND">India</option>
                                                    <option value="IDN">Indonesia</option>
                                                    <option value="IRN">Iran, Islamic Republic of</option>
                                                    <option value="IRQ">Iraq</option>
                                                    <option value="IRL">Ireland</option>
                                                    <option value="IMN">Isle of Man</option>
                                                    <option value="ISR">Israel</option>
                                                    <option value="ITA">Italy</option>
                                                    <option value="JAM">Jamaica</option>
                                                    <option value="JPN">Japan</option>
                                                    <option value="JEY">Jersey</option>
                                                    <option value="JOR">Jordan</option>
                                                    <option value="KAZ">Kazakhstan</option>
                                                    <option value="KEN">Kenya</option>
                                                    <option value="KIR">Kiribati</option>
                                                    <option value="PRK">Korea, Democratic People's Republic of</option>
                                                    <option value="KOR">Korea, Republic of</option>
                                                    <option value="KWT">Kuwait</option>
                                                    <option value="KGZ">Kyrgyzstan</option>
                                                    <option value="LAO">Lao People's Democratic Republic</option>
                                                    <option value="LVA">Latvia</option>
                                                    <option value="LBN">Lebanon</option>
                                                    <option value="LSO">Lesotho</option>
                                                    <option value="LBR">Liberia</option>
                                                    <option value="LBY">Libya</option>
                                                    <option value="LIE">Liechtenstein</option>
                                                    <option value="LTU">Lithuania</option>
                                                    <option value="LUX">Luxembourg</option>
                                                    <option value="MAC">Macao</option>
                                                    <option value="MKD">Macedonia, the former Yugoslav Republic of</option>
                                                    <option value="MDG">Madagascar</option>
                                                    <option value="MWI">Malawi</option>
                                                    <option value="MYS">Malaysia</option>
                                                    <option value="MDV">Maldives</option>
                                                    <option value="MLI">Mali</option>
                                                    <option value="MLT">Malta</option>
                                                    <option value="MHL">Marshall Islands</option>
                                                    <option value="MTQ">Martinique</option>
                                                    <option value="MRT">Mauritania</option>
                                                    <option value="MUS">Mauritius</option>
                                                    <option value="MYT">Mayotte</option>
                                                    <option value="MEX">Mexico</option>
                                                    <option value="FSM">Micronesia, Federated States of</option>
                                                    <option value="MDA">Moldova, Republic of</option>
                                                    <option value="MCO">Monaco</option>
                                                    <option value="MNG">Mongolia</option>
                                                    <option value="MNE">Montenegro</option>
                                                    <option value="MSR">Montserrat</option>
                                                    <option value="MAR">Morocco</option>
                                                    <option value="MOZ">Mozambique</option>
                                                    <option value="MMR">Myanmar</option>
                                                    <option value="NAM">Namibia</option>
                                                    <option value="NRU">Nauru</option>
                                                    <option value="NPL">Nepal</option>
                                                    <option value="NLD">Netherlands</option>
                                                    <option value="NCL">New Caledonia</option>
                                                    <option value="NZL">New Zealand</option>
                                                    <option value="NIC">Nicaragua</option>
                                                    <option value="NER">Niger</option>
                                                    <option value="NGA">Nigeria</option>
                                                    <option value="NIU">Niue</option>
                                                    <option value="NFK">Norfolk Island</option>
                                                    <option value="MNP">Northern Mariana Islands</option>
                                                    <option value="NOR">Norway</option>
                                                    <option value="OMN">Oman</option>
                                                    <option value="PAK">Pakistan</option>
                                                    <option value="PLW">Palau</option>
                                                    <option value="PSE">Palestinian Territory, Occupied</option>
                                                    <option value="PAN">Panama</option>
                                                    <option value="PNG">Papua New Guinea</option>
                                                    <option value="PRY">Paraguay</option>
                                                    <option value="PER">Peru</option>
                                                    <option value="PHL">Philippines</option>
                                                    <option value="PCN">Pitcairn</option>
                                                    <option value="POL">Poland</option>
                                                    <option value="PRT">Portugal</option>
                                                    <option value="PRI">Puerto Rico</option>
                                                    <option value="QAT">Qatar</option>
                                                    <option value="REU">Réunion</option>
                                                    <option value="ROU">Romania</option>
                                                    <option value="RUS">Russian Federation</option>
                                                    <option value="RWA">Rwanda</option>
                                                    <option value="BLM">Saint Barthélemy</option>
                                                    <option value="SHN">Saint Helena, Ascension and Tristan da Cunha</option>
                                                    <option value="KNA">Saint Kitts and Nevis</option>
                                                    <option value="LCA">Saint Lucia</option>
                                                    <option value="MAF">Saint Martin (French part)</option>
                                                    <option value="SPM">Saint Pierre and Miquelon</option>
                                                    <option value="VCT">Saint Vincent and the Grenadines</option>
                                                    <option value="WSM">Samoa</option>
                                                    <option value="SMR">San Marino</option>
                                                    <option value="STP">Sao Tome and Principe</option>
                                                    <option value="SAU">Saudi Arabia</option>
                                                    <option value="SEN">Senegal</option>
                                                    <option value="SRB">Serbia</option>
                                                    <option value="SYC">Seychelles</option>
                                                    <option value="SLE">Sierra Leone</option>
                                                    <option value="SGP">Singapore</option>
                                                    <option value="SXM">Sint Maarten (Dutch part)</option>
                                                    <option value="SVK">Slovakia</option>
                                                    <option value="SVN">Slovenia</option>
                                                    <option value="SLB">Solomon Islands</option>
                                                    <option value="SOM">Somalia</option>
                                                    <option value="ZAF">South Africa</option>
                                                    <option value="SGS">South Georgia and the South Sandwich Islands</option>
                                                    <option value="SSD">South Sudan</option>
                                                    <option value="ESP">Spain</option>
                                                    <option value="LKA">Sri Lanka</option>
                                                    <option value="SDN">Sudan</option>
                                                    <option value="SUR">Suriname</option>
                                                    <option value="SJM">Svalbard and Jan Mayen</option>
                                                    <option value="SWZ">Swaziland</option>
                                                    <option value="SWE">Sweden</option>
                                                    <option value="CHE">Switzerland</option>
                                                    <option value="SYR">Syrian Arab Republic</option>
                                                    <option value="TWN">Taiwan, Province of China</option>
                                                    <option value="TJK">Tajikistan</option>
                                                    <option value="TZA">Tanzania, United Republic of</option>
                                                    <option value="THA">Thailand</option>
                                                    <option value="TLS">Timor-Leste</option>
                                                    <option value="TGO">Togo</option>
                                                    <option value="TKL">Tokelau</option>
                                                    <option value="TON">Tonga</option>
                                                    <option value="TTO">Trinidad and Tobago</option>
                                                    <option value="TUN">Tunisia</option>
                                                    <option value="TUR">Turkey</option>
                                                    <option value="TKM">Turkmenistan</option>
                                                    <option value="TCA">Turks and Caicos Islands</option>
                                                    <option value="TUV">Tuvalu</option>
                                                    <option value="UGA">Uganda</option>
                                                    <option value="UKR">Ukraine</option>
                                                    <option value="ARE">United Arab Emirates</option>
                                                    <option value="GBR">United Kingdom</option>
                                                    <option value="USA">United States</option>
                                                    <option value="UMI">United States Minor Outlying Islands</option>
                                                    <option value="URY">Uruguay</option>
                                                    <option value="UZB">Uzbekistan</option>
                                                    <option value="VUT">Vanuatu</option>
                                                    <option value="VEN">Venezuela, Bolivarian Republic of</option>
                                                    <option value="VNM">Viet Nam</option>
                                                    <option value="VGB">Virgin Islands, British</option>
                                                    <option value="VIR">Virgin Islands, U.S.</option>
                                                    <option value="WLF">Wallis and Futuna</option>
                                                    <option value="ESH">Western Sahara</option>
                                                    <option value="YEM">Yemen</option>
                                                    <option value="ZMB">Zambia</option>
                                                    <option value="ZWE">Zimbabwe</option>
                                                </select>
                                            </div>
                                        </div>
                                        -->
                                        <div class="row checkbox-holder">
                                            <label class="col-4">Audio</label>
                                            <div class="col-4">
                                            	<c:if test="${ user.musicEnabled }">
                                            		<input type="checkbox" name="music" value="true" checked="true"><span>Music</span>
												</c:if>
												<c:if test="${ ! user.musicEnabled }">
                                                	<input type="checkbox" name="music" value="true"><span>Music</span>
                                                </c:if>
                                            </div>
                                            <div class="col-4 checkbox-input">
                                            	<c:if test="${ user.speechEnabled }">
                                                	<input type="checkbox" name="voice" value="true" checked="true"><span>Speech</span>
                                                </c:if>
                                                <c:if test="${ ! user.speechEnabled }">
                                                	<input type="checkbox" name="voice" value="true"><span>Speech</span>
                                                </c:if>
                                            </div>
                                        </div>
                                        <div class="row submitRow">
                                        	<input type="submit" class="btn btn-green" value="Update Profile">
                                        </div>
                                        <div class="row submitRow">
                                        	<input type="button" class="btn btn-danger changePassword" value="Change Password">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <div id="tab-2" class="tabs-tab tabs-body-tab custom-scroll hidden">
							     <table class="description-box">
                                    <tr>
                                        <td>Chips: <span class="spec-color">${ user.creditsFormatted }</span></td>
                                        <td>Gold: <span class="spec-color">${ user.bitletsIntFormatted }</span></td>
                                        <td>Level: <span class="spec-color">${ user.levelName }</span></td>
                                        <td><a href="/u/addChips" class="btn btn-orange">Get Chips</a></td>
                                    </tr>
                                </table>
                                <table class="simple-table chipsTable">
                                    <tr>
                                        <th>Date</th>
                                        <th>Chips</th>
                                        <th>Gold</th>
                                        <th>Cost</th>
                                        <th>For</th>
                                    </tr>
                                    <c:forEach var="transaction" items="${ transactions }">
                                    	<tr>
                                    		<td>${ transaction['date'] }</td>
	                                        <td>${ transaction['credits'] }</td>
	                                        <td>${ transaction['gold'] }</td>
	                                        <td>${ transaction['cost'] }</td>
	                                        <td>${ transaction['notes'] }</td>
                                    	</tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="tab-3" class="tabs-tab tabs-body-tab custom-scroll hidden">
    							<table class="description-box">
                                    <tr>
                                       	<td>Chips: <span class="spec-color">${ user.creditsFormatted }</span></td>
                                        <td>Gold: <span class="spec-color">${ user.bitletsIntFormatted }</span></td>
                                        <td>Level: <span class="spec-color">${ user.levelName }</span></td>
                                        <td><a href="/u/addChips" class="btn btn-orange">Get Chips</a></td>
                                    </tr>
                                </table>
                                <table class="simple-table historyTable">
                                    <tr>
                                        <th>ID</th>
                                        <th>Chips-Start</th>
                                        <th>Chips-End</th>
                                        <th>Balance</th>
                                        <th>Gold Move</th>
                                    </tr>
                                    <c:forEach var="game" items="${ games }">
                                    	<tr>
	                                        <td>${ game['id'] }</td>
	                                        <td>${ game['start'] }</td>
	                                        <td>${ game['end'] }</td>
	                                        <td>${ game['bal'] }</td>
	                                        <c:if test="${ game['gold'] gt 0}">
	                                        	<td class="imporvment up">${ game['gold'] }</td>
	                                        </c:if>
	                                        <c:if test="${ game['gold'] eq 0}">
	                                        	<td class="imporvment">--</td>
	                                        </c:if>
	                                        <c:if test="${ game['gold'] lt 0}">
	                                        	<td class="imporvment down">${ game['gold'] }</td>
	                                        </c:if>
	                                    </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            <div id="tab-4" class="tabs-tab tabs-body-tab custom-scroll hidden">
                                <table class="description-box">
                                    <tr>
                                        <td>Chips: <span class="spec-color">${ user.creditsFormatted }</span></td>
                                        <td>Gold: <span class="spec-color">${ user.bitletsIntFormatted }</span></td>
                                        <td>Level: <span class="spec-color">${ user.levelName }</span></td>
                                        <td><a href="/u/addChips" class="btn btn-orange">Get Chips</a></td>
                                    </tr>
                                </table>
                                <table class="simple-table achievementsTable">
                                    <tr>
                                        <th>S.No</th>
                                        <th>Achievement Description</th>
                                        <th>Score</th>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- /tabs -->
                </div>
            </main>
            
			<v2:footerNav />
		
		<!-- page-wrapper -->
		</div>
		
		<!-- popups -->
		<div class="overlay overlay-password" style="display: none;">
		    <div class="popup-name popup-mode1">
		        <p class="popup-mode1-title">Change Password <i class="fa fa-times-circle overlay-close" onclick="$('.overlay-password').hide();" aria-hidden="true"></i></p>
		        <div class="popup-mode1-content">
		        	<div class="error_message"> </div>
		        	<form id='password_form' autocomplete="on" action="/u/updatePasswordV2" onsubmit="return checkPassForm(this);">
			            <label for="current_pass">Old Password:</label>
		                <input  type="password" class="form-control" name="old" id="current_pass" placeholder="current pass" value="">
		                <br>
		                <label for="new_pass" >New Password:</label>
		                <input  type="password" class="form-control" name="new" id="new_pass" placeholder="new pass" value="" autocomplete="off">
		                <br>
		                <label for="new_conf" >Confirm Password:</label>
		                <input  type="password" class="form-control" name="new2" id="new_conf" placeholder="new pass (again)" value="" autocomplete="off">
		            </form>
		        </div>
		        <a href="javascript:void(0)" onclick="submitPassForm();" class="btn btn-green inlineButton">Submit</a>
		        <a class="btn btn-orange inlineButton" onclick="$('.overlay-password').hide();">Cancel</a>
		    </div>
		</div>
		
		<script>
			window.checkPassForm = function(form) {
				var newPass = $("#new_pass").val();
				var newPass2 = $("#new_conf").val();
				var currentPass = $("#current_pass").val();
				
				if (! currentPass || currentPass.length < 1) {
					$(".error_message").html("Please enter your current password!");
					return false;
				}
				if (! newPass || newPass.length < 1) {
					$(".error_message").html("Your new password cannot be blank!");
					return false;
				}
				if (newPass != newPass2) {
					$(".error_message").html("The passwords don't match, please try again.");
					return false;
				}
				
				return true;
			};
			
			window.submitPassForm = function() {
				var form = $("#password_form");
				if (checkPassForm(form)) {
					form.submit();
				}
			};
		
			$(document).ready(function() {
				$("body").addClass("profile");
				
				$(".hidden").hide();
				$(".hidden").removeClass("hidden");
				
				$(".changePassword").click(function() {
					$('.overlay-password').show();
				});
				
				var gender = "${ user.gender }".toLowerCase();
				$("#gender-rewrite").val(gender);
				$("#gender-rewrite option").each(function() {
					if (this.value.startsWith(gender)) {
						$(this).attr("selected", "selected");
						$(".genderRow .sod_placeholder").html($(this).text());
					}
				});
				
				<c:if test="${ ! empty user.selectedAgeGroup && user.selectedAgeGroup != 'null' && user.yearOfBirth lt 1 }">
					var age = "${ user.selectedAgeGroup }".toLowerCase();
					$("#age-rewrite").val(age);
					$("#age-rewrite option").each(function() {
						if (this.value.startsWith(age)) {
							$(this).attr("selected", "selected");
							$(".ageRow .sod_placeholder").html($(this).text());
						}
					});
				</c:if>
				
				$(".down").each(function() {
					$(this).html(Math.abs(parseInt($(this).html(), 10)));
				});
				
				<c:if test="${ ! empty achievements}">
					var achievements = ${ achievements };
					var allKeys = ["highestProfit", "royalFlush", "straightFlush", "highestOdds", "doubleCredits", "tripleCredits", "reachLevel"];
					var labels = {
						"highestProfit": "Highest profit from bet",
						"royalFlush": "Back a royal flush",
						"straightFlush": "Back a straight flush",
						"highestOdds": "Profit made from bet with highest odds",
						"doubleCredits": "Doubled credits by end of tournament",
						"tripleCredits": "Tripled credits by end of tournament",
						"reachLevel": "Highest level advance from tournament",
					};
					
					for (var index = 0; index < allKeys.length; index++) {
						var key = allKeys[index];
						var label = labels[key];
						var value = achievements[key];
						var pos = index + 1;
						
						var row = $("<tr></tr>");
						row.append($("<td>" + pos + "</td>"));
						row.append($("<td>" + label + "</td>"));
						row.append($("<td>" + value + "</td>"));
						
						$(".achievementsTable").append(row);
					}
				</c:if>
			});
		</script>
	</body>
</html> 