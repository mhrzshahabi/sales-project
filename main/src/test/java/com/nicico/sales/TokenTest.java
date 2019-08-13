package com.nicico.sales;

import org.apache.tomcat.util.codec.binary.Base64;

public class TokenTest {

	public static void main(String[] args) {
		String jwtToken = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyUm9sZXMiOiJST0xFX1VTRVIiLCJ1c2VyR3JvdXBzIjoiIiwiYXVkIjpbIlNhbGVzUmVzb3VyY2VJZCIsIk9BdXRoUmVzb3VyY2VJZCJdLCJ1c2VyX25hbWUiOiJhZG1pbiIsInNjb3BlIjpbInVzZXJfaW5mbyJdLCJ1c2VyRnVsbE5hbWUiOiLYp9iv2YXbjNmGINiz24zYs9iq2YUiLCJleHAiOjE1NjA4MzQzMzMsImp0aSI6IjJjZTFlNzdmLWFjZTUtNGU5NC1hNjk4LTJhYTJkOGI0MTk5ZCIsImNsaWVudF9pZCI6IlNhbGVzQ2xpZW50SWQifQ.v4MxTtVsm5UiU86Dk1zT0WrSaj7jmeAl0nNecbmqXxBrrZY_oCWeMn9tsljNPRzAKULwMjOZR31UIw4KGNXL3MwkVaXJsAJ3qSBX9oo8wKb0nPUKzSMhC2AvIKwe81ZmxQc67ClSpstuWI-Y8f9_LVO3qkbtbYel52usPMbq9LIfocqqLN1fvPsipo8Ft3gjR3L7jq52N0yo3XGX86LISibAVUIys5kQuqDNp4wvXdaZ0p2GnMPJgQ2JDOpS40LPfqoarP4hes5W0XUQMRTNobbOKuavyBKya0HLsoCHFDHoz0T19LqeI5_slRSrP4AW8URk9a3sU7H__iOLG2N3mg";

		System.out.println("--------------- Decode JWT ---------------");
		System.out.println("JWT: " + jwtToken);

		String[] jwtTokenSplit = jwtToken.split("\\.");
		String base64EncodedHeader = jwtTokenSplit[0];
		String base64EncodedBody = jwtTokenSplit[1];
		String base64EncodedSignature = jwtTokenSplit[2];

		Base64 base64Url = new Base64(true);

		System.out.println("--------------- JWT Header ---------------");
		String header = new String(base64Url.decode(base64EncodedHeader));
		System.out.println("JWT Header: " + header);


		System.out.println("--------------- JWT Body ---------------");
		String body = new String(base64Url.decode(base64EncodedBody));
		System.out.println("JWT Body: " + body);

		System.out.println("--------------- JWT Signature ---------------");
		System.out.println("JWT Signature: " + base64EncodedSignature);
	}
}
