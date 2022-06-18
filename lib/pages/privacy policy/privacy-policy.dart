import 'package:connevents/utils/fonts.dart';
import 'package:connevents/widgets/connevent-appbar-1.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConneventAppBar1(title: "Privacy Policy"),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top:12.0),
                child: Text("ConnEvents is glad to have you here. We're a ticketing and registration platform devoted to connecting people from all over the world together through live events. People from all over the world can create, discover, share, and register for events using our platform, mobile apps, and services\n\n"+
                    ' When we say "Organizer" in this Privacy Policy, we mean those who use the Services to produce events for people who use the Services (a) to get information about or attend events ("Consumers"), or (b) for any other reason. In these Terms, "Users," "you," or "your" refers to organizers, consumers, and third parties who use our Services collectively.\n\n'+
                    'With respect to Personal Data (defined below) collected through the Services, ConnEvents is the responsible party.\n',
                    textAlign: TextAlign.justify,
                    style: gilroyLight),
              ),
              Text('Our Privacy Statement\n',style: gilroyExtraBold),
              Text('Application\n',style: gilroyBold),
              Text(" This Privacy Policy outlines our policies regarding information collected from Users on or via the Services that can be associated with, pertains to, or could be used to identify a person ('Personal Data'). We are committed to protecting the privacy of your Personal Data. As a result, we've developed our Privacy Policy. Please read this Privacy Policy carefully because it contains crucial information about your Personal Data and other data. \n\n"+
                   'As used in this Privacy Policy, "non-Personal Data" refers to any information that does not identify a person and/or cannot be used to identify a person. We may gather Non-Personal Data when you engage with the Services. Non-Personal Data is exempt from the limitations and requirements set forth in this Privacy Policy regarding our collection, use, disclosure, transfer, and storage/retention of Personal Data.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight),
              Text('Personal Data That We Collect.',style: gilroyExtraBold),
              Text('We may gather Personal Data when you use or interact with us through the Services. This will be on our own behalf at times, and on behalf of an Organizer who is utilizing our Services to host an event at other times. This distinction is critical for the purposes of some data protection rules, and it is addressed in greater detail below.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight),
              Text('Information Collected From All Users.',style: gilroyExtraBold),
              RichText(
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                text: 'Information you provide to us: ',
                style: gilroyBold,
                children: [
                  TextSpan(
                    style:gilroyLight ,
                    text:'We gather Personal Data from all Users when they voluntarily supply it to the Services, such as when they register for access to the Services, contact us with questions, participate in one of our surveys, or browse or utilize certain portions of the Services. Your name, address, email address, and any other information that you choose to supply and/or that enables Users to be personally recognized are examples of Personal Data that we may collect. We automatically collect the following data: We also collect certain technical data that is automatically supplied to us from the computer, mobile device, and/or browser that you use to use the Services ("Automatic Data"). Automatic Data includes, for example, a unique identifier associated with your access device and/or browser (such as your Internet Protocol (IP) address), characteristics of your access device and/or browser, statistics on your activities on the Services, information about how you came to the Services, and data collected through Cookies, Pixel Tags, Local Shared Objects, Web Storage, and other similar technologies. Our Cookie Statement contains further information about how we use Cookies and other similar tracking technology. We may connect such Non-Personal Data (including Non-Personal Data we obtain from third parties) with your Personal Data when you register for the Services or otherwise submit Personal Data to us. In this case, any merged data will be treated as your Personal Data until it can no longer be associated with you or used to identify you.\n'
                  )
                ]
              )),
              Text('Information Collected From Organizers.',style: gilroyBold),
              Text('We will collect more Personal Data from you if you are a Consumer, sometimes for our own purposes and occasionally on behalf of an Organizer \n\n'+
                  "ConnEvents Properties or Applications offer the following information: You will supply financial information (e.g., your credit card number and expiration date, billing address, etc.) if you register for a paid event, some of which may constitute Personal Data. Organizers can also set up event registration pages on the Services to collect almost any information from Consumers in conjunction with registration for an Organizer's event listed on the Services. ConnEvents has no control over how an Organizer registers or what Personal Data they collect. ConnEvents receives and may use the information you supply when you register for or otherwise provide information to ConnEvents in connection with an Organizer event or activity, whether that information is yours or a third party's, in connection with a purchase, registration, or transfer.\n\n"+
                  'We may also gather Personal Data through third-party sources, such as Organizers, other Consumers, social media or other third-party integrations, your credit card issuing bank, our payment processing partners, or other third parties.\n\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight),
              Text('How We Use Your Personal Data.',style: gilroyExtraBold),
              Text('We collect and use the Personal Data we collect in a manner that is consistent with this Privacy Policy, and applicable privacy laws. We may use the Personal Data as follows:\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Specific Reason.',style: gilroyBold),
              Text('If you give Personal Data for a specific purpose, we may use it in connection with that purpose. If you contact us by email, for example, we will use the Personal Data you supply to react to your query or solve your problem, and we will respond to the email address from which you contacted us\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Access and Use.',style: gilroyBold),
              Text('We will use your Personal Data to provide you with access to or use of the Services or any functionality thereof, as well as to analyze your usage of such Services or functionality, if you give Personal Data in order to get access to or use of the Services or any functionality thereof. For example, if you provide Personal Data about your identification or qualifications to use specific parts of the Services, we will use that information to decide whether or not to provide you access to those parts of the Services and to assess your continued qualification to use those parts of the Services.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Internal Business Purposes.',style: gilroyBold),
              Text('We may use your Personal Data for internal business purposes, such as improving the content and functionality of the Services, better understanding our Users, improving the Services, protecting against, identifying, or addressing wrongdoing, enforcing our Terms of Service, managing your account and providing you with customer service, and generally managing the Services and our business.\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('ConnEvents and Organizer Marketing.',style: gilroyBold),
              Text("We may use your Personal Data for marketing and advertising purposes, such as (but not limited to) email marketing, SMS marketing, display media, and device targeting (such as tablets, mobile devices and televisions). We do this to keep you informed about services or events we think you'll like, generate promotional or marketing materials, and show ConnEvents or event-related content and advertising on or off the Services that we think you'll like. We may also do this on behalf of an Organizer, such as if your previous contacts with an Organizer indicate that you might be interested in a specific type of event.\n"+
                  "Advertisements for our Services may appear on third-party websites, such as social media platforms. We also give event organizers tools to assist them promote their events on third-party websites and social media platforms. If you see an advertisement on a third-party website or social media platform, it's because we or the Organizer paid the third-party or social media platform to display the advertisement to our Users or others with comparable characteristics. In some cases, this may entail sharing your email address or other contact information with a third party or social media platform so that they can recognize you as one of our Users, or identify other people who share similar characteristics with you so that we can show them advertisements for our Services (or for our Organizer's events). Please contact us at Support@connevents.com if you no longer want your Personal Data to be used for these purposes. You may need to contact the Organizer directly if you see an Organizer's advertisement",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Organizer Emails.',style: gilroyBold),
              Text("We allow Organizers to use our email facilities to contact Consumers for current and past events, therefore you may receive emails from our system that are sent on their behalf by such Organizers. If you registered for an event through the Services, the Organizer has access to your email address. Organizers may, however, import email addresses from external sources and send emails to those addresses through the Services, and we will deliver those communications on the Organizer's behalf. ConnEvents is not responsible for sending these emails; instead, it is the organizer's responsibility.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Use of Interest-Based Data',style: gilroyBold),
              Text("We make educated guesses about the types of events or activities you might enjoy. These inferences may be used by us, including on behalf of Organizers, to assist target advertising or customize recommendations to you. This could be done in an aggregated or generalized manner.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Other Purposes',style: gilroyBold),
              Text("If we intend to use any Personal Data in a way that is inconsistent with this Privacy Policy, we will notify you prior to or at the time the Personal Data is collected, or we will obtain your agreement after the data is received but before it is used.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Aggregated Personal Data.',style: gilroyBold),
              Text("We frequently perform research on our customer demographics, interests, and behavior based on Personal Data and other information that we have acquired in an ongoing attempt to better understand and serve our Users. This type of research is usually done in an aggregated form that does not identify you. When Personal Data is aggregated, it becomes Non-Personal Data for the purposes of this Privacy Policy\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How We Disclose And Transfer Your Personal Data.',style: gilroyBold),
              Text("We are not in the business of selling your personal information to other parties. This information is a critical component of our interaction with you. As a result, we will not sell your personal information to third parties, including marketers. As set forth in this Privacy Policy, there are some circumstances in which we may disclose, transfer, or share your Personal Data with third parties without additional notification to you\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Business Transfers.',style: gilroyBold),
              Text("We may sell or buy businesses or assets as our company grows. Personal Data may be part of the transferred assets in the event of a corporate sale, merger, reorganization, dissolution, or similar event. In the event of such an event, we may also disclose your Personal Data as part of our due diligence. You agree that any successor to ConnEvents (or its assets) shall have the right to use your Personal Data and other information in line with the provisions of this Privacy Policy\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Parent Companies, Subsidiaries and Affiliates',style: gilroyBold),
              Text("For the purposes of this Privacy Policy, we may also share your Personal Data with our parent businesses, subsidiaries, and/or affiliates. Our parent companies, subsidiaries, and affiliates will be obligated to protect your personal information in line with this policy.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Agents, Consultants and Service Providers.',style: gilroyBold),
              Text("Your Personal Data may be shared with our contractors and service providers who process Personal Data on ConnEvents' behalf to execute certain business-related services. Our marketing agencies, online advertising providers, data enhancement and data services providers, database service providers, backup and disaster recovery service providers, email service providers, payment processing partners, customer service, tech support, hosting companies, and others are among the companies we work with. We may give them with information, including Personal Data, in connection with their fulfillment of such activities when we hire another company to do so.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Organizers.',style: gilroyBold),
              Text("Furthermore, whether you register for an event, sign up for communications, enter a contest, or otherwise provide your Personal Data (such as via a web form) to contact with an Organizer or participate in an Organizer event, such information is shared with that Organizer. For example, if you fill up a web form for an Organizer offer, activity, or event, the Organizer will receive your name and email address. After that, the Organizer may send you marketing or other messages, which may be subject to its own privacy policy. You may also receive information messages connected to the service, event, activity, or information in which you've expressed interest if you supply your mobile phone number.\n"+
                  "When you buy tickets to an event, register for an event, donate to an event, transfer an event ticket or registration to another person, enter a contest, or otherwise input your Personal Data (such as through a web form), or otherwise communicate with an Organizer, or participate in or express interest in an Organizer or Organizer event or activity, that Organizer will receive the information you provide, including your Personal Data. Other third parties involved in or on behalf of whom an event or activity is promoted may also receive Personal Data. For example, when it comes to fundraising sites, we may share your Personal Data with both the fundraiser's organizer charity and the organizer of the event to which the fundraiser is tied. In some cases, an Organizer may appoint a third party, who may or may not be linked with the Organizer, to construct an event or fundraising page on the Organizer's behalf (we refer to these third parties as 'third parties') ('Third Party Organizers').\n"
                 +"With respect to your Personal Data, we are not responsible for the acts of these Organizers or their Third Party Organizers (or any downstream recipients of your Personal Data). Before providing Personal Data or other information in connection with an event (and, if applicable and available, their appointed Third Party Organizers), it is critical that you review the applicable policies of the Organizers (and, if applicable and available, their appointed Third Party Organizers) of that event (and, if applicable, the related fundraising page). If you are a member of an Organizer's ConnEvents organization, your Personal Data will be available to the Organizer and shared with those Third Party Organizers who have been granted permission by the Organizer to view all members of the Organizer's organization.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Social Media and Other Third Party Connections.',style: gilroyBold),
              Text("a. Connecting Your ConnEvents Account to Social Media Services. You can link your ConnEvents account to third-party services such as Facebook, in which case we may collect, use, disclose, transmit, and store/retain information about your account with those third-party services in line with this Privacy Policy. If you connect with Facebook, for example, we will store your Facebook id, first name, last name, email, location, friends list, and profile picture and use them to connect with your Facebook account to provide certain functionality on the Services, such as recommending events to your Facebook friends and sharing events you are interested in or attending with specific groups of people, such as your Facebook friends.\n\n"+
                  "b. “Liking” or “Following” ConnEvents on Social Media. We may also collect information from you when you 'like' or 'follow' us on Facebook, Instagram, Twitter, or other social networking sites (to the extent we give that possibility), such as your name, email address, and any related comments or material you post. If you sign up for one of our promotions or submit information to us through social networking sites, we may gather your information as well.\n"+
                  "c. Facebook Plug-Ins and Links on Our Pages. ConnEvents' own website may also feature links to Facebook, such as the 'Like' or 'Share' buttons on Facebook or other social plug-ins. When you use these features and links, your browser establishes a direct connection with Facebook servers, and Facebook receives information about your browser and behavior, which it may associate with your Facebook user account. Please visit Facebook's own policies for additional information on how they use data.\n\n"+
                   "d. Additional Facebook Marketing and Connectivity by Organizers. Furthermore, if you are a member of Facebook (or another social media platform) and provide Personal Data to an Organizer, the Organizer may use that Personal Data to send you advertising and offers via Facebook (or another social media platform), including when you are on Facebook (or another social media platform). To enable data integration and advertising, the Organizer may use tools that we provide, as well as collaborate with other parties. There may be an option to opt out of this type of advertising on Facebook and other social media platforms. Please take a look at their user settings and support pages to discover more about how they can assist you in managing your privacy and marketing preferences.\n\n"+
                   "e. Third party services and integrations. Through our platform, ConnEvents may provide you the ability to contract directly with third parties and/or interface with third-party services or applications. In some cases, we shall share your Personal Data with other entities in order to fulfill your request or provide the services you have requested.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Legal Requirements.',style: gilroyBold),
              Text("We may disclose your Personal Data if required to do so by law, such as in response to a subpoena or request from law enforcement, a court, or a government agency (including in response to public authorities to meet national security or law enforcement requirements), or if we believe in good faith that such action is necessary to: \n"+
                  "             * comply with a legal obligation.\n\n"+
                  "             * preserve or defend our rights, interests, or \n"
                  "               property, as well as the rights, interests, and \n "
                  "               property of others.\n\n"+
                  "             * prevent or investigate any potential wrongdoing \n "
                  "               involving the Services.\n\n"+
                  "             * take action in an emergency to protect the \n "
                "                 personal safety of Users of the Services or the \n "
                  "               general public, or \n\n"+
                  "             * avoid legal liability.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How We Store Your Personal Data.',style: gilroyBold),
              Text("We may store Personal Data ourselves, or we may transmit it to third parties who will store it in compliance with our Privacy Policy. We take reasonable precautions to protect Personal Data obtained through the Services against loss, misuse, unauthorized use, access, unintended disclosure, modification, and destruction. No network, server, database, or Internet or email transmission, on the other hand, is ever completely secure or error-free. As a result, you should exercise extreme caution when determining what information you transmit us electronically. When revealing any Personal Data, please bear this in mind\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How You Can Access, Update, Correct or Delete Your Personal Data',style: gilroyBold),
              Text("You have the ability to view or remove your Personal Data that we have on file for you. If you are a registered User, you can do so by checking in and going to the Account Settings page to download a machine-readable copy of your Personal Data and/or delete it. Some of your Personal Data can also be edited directly through your account. In some situations, you can contact us to request that we correct or amend any erroneous Personal Data, and we will evaluate your request in compliance with applicable regulations\n"+
                  "If a Consumer requests that their data be deleted, ConnEvents is authorized to remove or anonymize the requesting Consumer's Personal Data from the Services, even if this means making it unavailable to the Organizer through the Services. If you are a Consumer, you should be aware that even if ConnEvents deletes or anonymizes your Personal Data at your request or in accordance with this Policy, your Personal Data may still be available in the Organizer's databases if it was transmitted to the Organizer before ConnEvents received or took action on any deletion or anonymization activity.\n"+
                  " Unregistered Users can also use the contact information below to view, update, correct, or delete Personal Data and exercise these rights. All inquiries will be considered and responded to in accordance with the legislation.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('How Long We Retain Your Personal Data.',style: gilroyBold),
              Text("Your Personal Data may be kept for as long as you are a registered user of the Services. By going to the Account Settings page, you can delete your account. However, we may keep Personal Data for a longer period if necessary or permitted by applicable laws. Even if we delete your Personal Data, it may be retained for a longer amount of time on backup or archive media for legal, tax, or regulatory purposes, or for legitimate and reasonable business objectives.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Cookies, Pixels Tags, Local Shared Objects, Web Storage And Similar Technologies.',style: gilroyBold),
              Text("Please refer to our Cookie Statement for more information about our use of cookies and other similar tracking technologies.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Your Choices.',style: gilroyBold),
              Text("You have several choices available when it comes to your Personal Data:\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Limit the Personal Data You Provide.',style: gilroyBold),
              Text("You can use the Services without supplying any Personal Data (save to the extent that Automatic Data is considered Personal Data under applicable legislation) or with limited Personal Data. You may not be able to use some features of the Services if you choose not to supply any Personal Data or limit the Personal Data you provide.\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Opt Out from Electronic Communications.',style: gilroyBold),
              Text("(a) ConnEvents Marketing Communications. To the extent you have registered for the Services or purchased a ticket and/or registration to an event listed on the Services, ConnEvents may send you electronic communications marketing or advertising the Services themselves or events on the Services, in accordance with your marketing preferences. You can also 'unsubscribe'from receiving these electronic communications by clicking the 'Unsubscribe' link at the bottom of each such electronic communication. You can also change your email options at any time by checking in (or signing up and then logging in), going to 'Account,' and then 'Email Preferences'.\n\n"+
                '(b) Organizer-initiated Communications. Organizers may send electronic communications to people on their email subscription lists, which may include Consumers who have already registered for their events on the Services, using our email capabilities. Despite the fact that these electronic communications are sent through our system, ConnEvents has no control over the content or recipients of these messages. Organizers are only allowed to use our email tools if they follow all applicable regulations. On each of these emails, ConnEvents includes a "Unsubscribe" link that allows recipients to "opt out" of receiving electronic communications from the specific Organizer.\n\n'+
                  '(c) Social Notifications. You will receive these social notifications if you connect your Facebook account or join up for other social network integrations whose product features include social notifications (i.e., updates on what your friends are doing on the Services). Toggle your social settings to private or disconnect such integration to manage these social notifications.\n\n'+
                  "(d) Transactional or Responsive Communications. ConnEvents' electronic communications are responsive to your needs in some cases. Only by contacting us will you be able to stop getting these types of emails. You will no longer receive any updates on events you have produced (including payout difficulties) or events you have registered to attend if you choose to stop receiving all electronic communications from us or through our system (including emails with your tickets). We don't advocate doing this unless you're planning to stop using the Services, aren't currently registered for an event, aren't actively organizing an event, and won't need to hear from us or through our system again.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Do Not Track.',style: gilroyBold),
              Text("You can use the Services without supplying any Personal Data (save to the extent that Automatic Data is considered Personal Data under applicable legislation) or with limited Personal Data. You may not be able to use some features of the Services if you choose not to supply any Personal Data or limit the Personal Data you provide.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Exclusions.\n',style: gilroyExtraBold),
              Text('Personal Data Provided to Others.',style: gilroyBold),
              Text("This Privacy Policy does not apply to any Personal Data that you provide to another User or visitor through the Services or through any other means, including to Organizers on event pages or information posted by you to any public areas of the Services.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text('Third Party Links.',style: gilroyBold),
              Text('This Privacy Policy applies only to the Services. The Services may contain links to other websites not operated or controlled by us (the "Third Party Sites"). The policies and procedures we described here do not apply to the Third Party Sites. The links from the Services do not imply that we endorse or have reviewed the Third Party Sites. We suggest contacting those sites directly for information on their privacy policies.\n\n',
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("Children - Children's Online Privacy Protection Act.",style: gilroyBold),
              Text("We do not collect Personal Data from children under the age of thirteen without their consent (13). Please do not submit any Personal Data through the Services if you are under the age of thirteen (13). We encourage parents and legal guardians to keep an eye on their children's online activities and to help us enforce our Privacy Policy by educating their children to never provide Personal Data over the Services without their permission. If you believe a child under the age of 13 has contributed Personal Data to us through the Services, please notify us and we will make every effort to remove the information from our databases.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("International Privacy Laws.",style: gilroyBold),
              Text("If you are visiting the Services from outside the United States, please be aware that you are sending information (including Personal Data) to the United States where our servers are located. That information may then be transferred within the United States or back out of the United States to other countries outside of your country of residence, depending on the type of information and how it is stored by us. These countries (including the United States) may not necessarily have data protection laws as comprehensive or protective as those in your country of residence; however, our collection, storage and use of your Personal Data will at all times continue to be governed by this Privacy Policy.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("Changes To This Privacy Policy.",style: gilroyBold),
              Text("From time to time, the Services and our business may change. As a result, we may need to make modifications to this Privacy Policy from time to time. We retain the right to amend or modify this Privacy Policy at any time in our sole discretion (collectively, 'Modifications'). Changes to this Privacy Policy will be posted on the Site and the 'Updated' date at the top of this Privacy Policy will be updated. ConnEvents may, but is not obligated to, provide you with additional notice of such Modifications, such as by email or in-Service notices, in certain instances. Modifications shall take effect thirty (30) days from the 'Updated' date or such other date as may be disclosed to you in any other notification\n\n"+
                  "Please examine this policy on a regular basis, particularly before providing any Personal Data. This Privacy Policy was last updated on the above-mentioned date. Continued use of the Services after any Modifications to this Privacy Policy go into effect implies acceptance of the Modifications. You shall stop accessing, browsing, and otherwise using the Services if any Modification to this Privacy Policy is unacceptable to you.\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),
              Text("Dispute Resolution.",style: gilroyBold),
              Text("If you have a complaint about ConnEvents's privacy practices you should write to us at: Support@connevents.com. We will take reasonable steps to work with you to attempt to resolve your complaint\n\n",
                  textAlign: TextAlign.justify,
                  style: gilroyLight ),


            ],
          ),
        ),
      ),

    );
  }
}
