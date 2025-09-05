//
//  RichText.swift
//  ISwiftUIKit.TextHtml
//
//  Created by Taiyou on 2025/8/8.
//

//
//  RichText.swift
//
//
//  Created by 이웅재(NuPlay) on 2021/07/26.
//  https://github.com/NuPlay/RichText

import SwiftUI

public struct RichText: View {
    @State private var dynamicHeight: CGFloat = .zero
    
    let html: String
    var configuration: Configuration
    var placeholder: AnyView?
    
    public init(html: String, configuration: Configuration = .init(), placeholder: AnyView? = nil) {
        self.html = html
        self.configuration = configuration
        self.placeholder = placeholder
    }

    public var body: some View {
        GeometryReader{ proxy in
            ZStack(alignment: .top) {
                WebView(width: proxy.size.width, dynamicHeight: $dynamicHeight, html: html, configuration: configuration)

                if self.dynamicHeight == 0 {
                    placeholder
                }
            }
        }
        .frame(height: dynamicHeight)
    }
}

struct RichText_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            RichText(
                html:
//            """
//            <h1 style="background-color: white;">Lorem Ipsum Test</h1>
//            <img 
//                src="https://miro.medium.com/v2/resize:fit:1400/1*JLYlSLSK8-AZo8gt9UdYqA.jpeg" 
//                alt="Denali mountain landscape" 
//              />
//            <a href="https://manabuy.com">链接</a>
//            <a href=\\\"https://manabuy.com/pubg-mobile-top-up\\\" target=\\\"_blank\\\" rel=\\\"noopener\\\"><strong>PUBG Mobile 4.0</strong></a>
//            <p style="background-color: white;">
//              Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae suscipit neque. Nullam
//              imperdiet justo at felis dictum, nec laoreet risus fermentum. Mauris suscipit libero vel
//              erat porttitor, ac porttitor nisi pulvinar.
//            </p>
//            <p style="background-color: white;">
//              Donec in mi vel sem pharetra pulvinar. Aliquam erat volutpat. Morbi posuere justo at
//              efficitur pharetra. Aenean nec blandit nibh. Proin vel urna eget odio posuere blandit.
//            </p>
//            <h2 style="background-color: white;">Subheading</h2>
//            <p style="background-color: white;">
//              Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae;
//              Cras malesuada velit sit amet metus dapibus, at tristique est porttitor. Nunc lacinia
//              lectus sed quam lacinia, vel porta nulla fermentum. Curabitur at urna non nisl
//              scelerisque consequat.
//            </p>
//            <p style="background-color: white;">
//              Sed vitae turpis vitae purus accumsan faucibus. Suspendisse vel nibh tellus. Etiam et
//              tempor ante. Suspendisse sit amet orci id nisi euismod blandit. In hac habitasse platea
//              dictumst.
//            </p>
//            <p style="background-color: white;">
//              Pellentesque dignissim lacinia nisl at pretium. Etiam a rutrum nisi. Integer tincidunt
//              ipsum ut sapien gravida, a bibendum massa fermentum. Vivamus lacinia libero in nunc
//              eleifend suscipit. Maecenas ut tristique magna.
//            </p>
//            """
                """
                <html>
                 <head></head>
                 <body>
                  <p class="otl-paragraph">The PUBG Mobile 4.0 Steampunk Frontier update brings lots of changes. There is a new map, new ways to play, and new weapons and vehicles. You can now visit places like the Magic Mirror Castle. You can use the Ghostie companion. You can fly on the Magic Broom. Look at how many more people played after the update:</p> 
                  <table class="outline-table" style="border-style: solid; border-width: 1px;" border="1"> 
                   <tbody> 
                    <tr> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Month</strong></span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Estimated Monthly Active Players</strong></span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Change in Players</strong></span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Percentage Change</strong></span></p> </td> 
                    </tr> 
                    <tr> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">July 2025</span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">47.4 million</span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">+19.6 million</span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">0.703</span></p> </td> 
                    </tr> 
                    <tr> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">August 2025</span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">60.0 million</span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">+12.6 million</span></p> </td> 
                     <td style="width: 185px; max-width: 185px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="185" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">0.266</span></p> </td> 
                    </tr> 
                   </tbody> 
                  </table> 
                  <blockquote style="padding-left: 1em; text-indent: 0em;">
                   Want to get rewards faster? ManaBuy has cheap top-ups. You can start playing new stuff and get your favorite rewards this season.
                  </blockquote> 
                  <h2 style="text-indent: 0em;"><span style="text-indent: 0em;">New Map</span></h2> 
                  <div> 
                   <div> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Map Overview</h3> 
                    <p class="otl-paragraph">Get ready to check out Steampunk Frontier, the newest map in <a href="https://manabuy.com/pubg-mobile-top-up" rel="noopener">PUBG Mobile 4.0</a>. This map looks different because it has a steampunk style. You will see gears, steam engines, and clockwork machines all over. There are old trains, hot air balloons, and a huge castle inspired by Attack on Titan. The map feels busy with moving trains, bright lights, and machine noises.</p> 
                    <p class="otl-paragraph">Here is a quick look at what makes Steampunk Frontier cool:</p> 
                    <table class="outline-table" style="border-style: solid; border-width: 1px;" border="1"> 
                     <tbody> 
                      <tr> 
                       <td style="width: 210.39215686274508px; max-width: 210.39215686274508px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="210.39215686274508" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Design Element Category</strong></span></p> </td> 
                       <td style="width: 529.6078431372549px; max-width: 529.6078431372549px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="529.6078431372549" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Description</strong></span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 210.39215686274508px; max-width: 210.39215686274508px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="210.39215686274508" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Themed Locations</span></p> </td> 
                       <td style="width: 529.6078431372549px; max-width: 529.6078431372549px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="529.6078431372549" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Aetherholm is the main train station with a secret clock tower. Cargo Hub is an industrial area. There is a Train Platform and a Rollercoaster Checkpoint where you can ride a rollercoaster.</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 210.39215686274508px; max-width: 210.39215686274508px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="210.39215686274508" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Mobility Features</span></p> </td> 
                       <td style="width: 529.6078431372549px; max-width: 529.6078431372549px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="529.6078431372549" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">You can use hot air balloons and big steam trains like Epoch Cargo Train and Express Train. There are cabins you can go inside and loot drops to find.</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 210.39215686274508px; max-width: 210.39215686274508px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="210.39215686274508" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Interactive Devices &amp; Vendors</span></p> </td> 
                       <td style="width: 529.6078431372549px; max-width: 529.6078431372549px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="529.6078431372549" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Clockwork Attendant gives you buff drinks. Clockwork Merchant lets you trade tokens. Lucky Cog Machine is for gambling tokens. Mechanical Cache gives puzzle rewards.</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 210.39215686274508px; max-width: 210.39215686274508px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="210.39215686274508" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Themed Gear</span></p> </td> 
                       <td style="width: 529.6078431372549px; max-width: 529.6078431372549px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="529.6078431372549" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">You can use a Mechanical Grappling Hook. Giant Transformation Serum lets you turn into a Titan.</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 210.39215686274508px; max-width: 210.39215686274508px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="210.39215686274508" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Visual &amp; Audio Design</span></p> </td> 
                       <td style="width: 529.6078431372549px; max-width: 529.6078431372549px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="529.6078431372549" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">The map has steampunk looks and clockwork sounds. Utgard Castle has towers you can break and Titans that walk around.</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 210.39215686274508px; max-width: 210.39215686274508px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="210.39215686274508" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Gameplay Mechanics</span></p> </td> 
                       <td style="width: 529.6078431372549px; max-width: 529.6078431372549px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="529.6078431372549" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">There is a steam coin system, train jobs, interactive NPCs, and new ways to play.</span></p> </td> 
                      </tr> 
                     </tbody> 
                    </table> 
                    <p class="otl-paragraph">The map includes classic battlegrounds like Arenal, Livik, and Rondo. Each place looks different but keeps the steampunk feel. The main station, Aetherholm, is a fun spot to visit. You can find secret rooms, call cargo trains, and get hidden loot.</p> 
                    <p class="otl-paragraph">Key Features</p> 
                    <p class="otl-paragraph">Steampunk Frontier adds lots of new things to do. You can move in ways you have not tried before. Here are some of the best features you will see:</p> 
                    <ul> 
                     <li>ODM Gear: Use grappling hooks and gas cables to swing in the air. You can move across rooftops or get away from danger fast.</li> 
                     <li>Blades for Combat: The ODM Gear has sharp blades. You can fight enemies on the ground or while flying.</li> 
                     <li>Titan Transformation: Drink the Giant Transformation Serum to become a Titan. You get more health, jump higher, and break things. If you find the rare Attack Titan Serum, you can stay as the Attack Titan longer.</li> 
                     <li>Steam Glider: When you land on the map, the Steam Glider helps you land quickly and safely.</li> 
                     <li>Trains and Balloons: Ride the Epoch Cargo Train or get in a hot air balloon. These help you travel fast and find loot.</li> 
                     <li>Interactive Economy: Get Steam Coins by riding trains or opening crates. Spend them at merchants for drinks, ammo, or special gear.</li> 
                     <li>Puzzle and Luck Machines: Try the Lucky Cog Machine or solve puzzles at the Mechanical Cache for extra prizes.</li> 
                    </ul> 
                    <p class="otl-paragraph">Players say this map feels different from other PUBG Mobile maps. You will see more action up high, flickering lights, and areas that are hard to see in. The map makes you think quickly and work with your team. Many players like the new look and the mix of action and strategy. Some say it takes time to learn, but the new features make every game fun.</p> 
                    <p class="otl-paragraph">Tip: Go explore Utgard Castle. You might meet Titans and find towers you can break. It is a good spot for action and rare loot!</p> 
                    <h2 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Gameplay Updates</h2> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">New Mechanics</h3> 
                    <p class="otl-paragraph">You’re going to notice some wild changes when you jump into PUBG Mobile 4.0. The game now feels more magical and unpredictable. You can cast spells, swing wands, and even ride broomsticks, thanks to the Harry Potter collaboration. If you love fantasy, you’ll enjoy the Hogwarts-inspired map and magical combat. There’s a new Zombie Takeover mode where you control zombies and battle other players. This twist adds a fresh PvP challenge.</p> 
                    <p class="otl-paragraph">You can build your own Magical Home. Decorate it with glowing effects and set up defensive spells. It’s your personal base, and you can show it off to friends. The haunted maze is another cool addition. You’ll find King’s Crates filled with supernatural powers and traps. Watch out for the Ghosty Companion. This little ally auto-revives you, heals you during fights, and scans for enemies. It’s like having a secret helper in every match.</p> 
                    <p class="otl-paragraph">The Mortar weapon changes how you fight. You can fire directly or launch long-range strikes across the map. The Spooky Soiree mode brings Halloween vibes with evolving Ghost Companion abilities and a powerful Banshee Wail ultimate. You’ll also see phantom chandeliers and collapsing staircases. These features force you to adapt and think fast.</p> 
                    <p class="otl-paragraph">Competitive players have mixed feelings about the new Unfail Horror Mode. Some love the 4v1 gameplay and teamwork. Others miss the classic battle royale style. The Popularity Battle Mode is a hit, though. It mixes strategy and social play, letting you work with your squad in new ways.</p> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">System Improvements</h3> 
                    <p class="otl-paragraph">PUBG Mobile 4.0 isn’t just about new mechanics. You’ll see smoother gameplay and better visuals. Reloading animations look more realistic, making every fight feel intense. The sound effects are richer, especially in spooky areas. The Beach Carnival in Lipovka adds fun with rides and a Ferris wheel.</p> 
                    <p class="otl-paragraph">Technical upgrades mean you get better graphics and less lag. The game now works on Android 5.1.1+ and iOS 12.0+, but older Apple A7 chips aren’t supported. You need at least 2 GB RAM and 4 GB free storage for smooth play. The update size is about 2.4 GB, but it can reach up to 20 GB with extra content. You can tweak graphics settings for better frame rates. Network improvements help with real-time abilities like Ghostie and Mirror Portal.</p> Tip: Try out the new reload animations and Mortar weapon. These changes make every match more exciting and tactical.
                   </div> 
                   <div>
                    &nbsp;
                   </div> 
                   <div>
                    <br />
                    <img src="https://static-cdn.manabuy.com/wz_20250324103741/pubgm_20250324110852/pubg-mobile-new-season-update-steampunk-frontier-rewards_20250827102037/download_image_202508271025.webp" alt="" width="700" height="394" />
                   </div> 
                   <div> 
                    <h2 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Weapons &amp; Vehicles</h2> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">New Weapons</h3> 
                    <p class="otl-paragraph">You get to try out the Mortar, the newest weapon in PUBG Mobile 4.0. This heavy weapon lets you attack enemies from far away, even if they hide behind cover. The Mortar can hit targets up to 200 meters away. You can use it to break up enemy squads or force campers to move. It changes how you play, especially if you like to control big open spaces or defend a spot with your team.</p> 
                    <p class="otl-paragraph">The update also brings the pickaxe as a new melee weapon. The pickaxe deals 60 damage and helps you destroy certain non-metallic surfaces. Now you can make your own cover or open up new paths during a fight. These changes give you more ways to win, whether you like to rush or play it safe.</p> Tip: Practice with the Mortar in training mode. You will learn how to aim and time your shots for the best results. 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">New Vehicle</h3> 
                    <p class="otl-paragraph">The Magic Broom is the new vehicle everyone is talking about. You and a friend can fly across the map at 80 km/h, or boost up to 120 km/h. Every 7 seconds, you can use the Sweep Attack to knock back enemies. But watch out—if you boost too hard, your passenger might fall off! Good teamwork makes the Magic Broom a real game-changer. Use it to escape danger, chase down enemies, or surprise squads from above.</p> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Balancing Changes</h3> 
                    <p class="otl-paragraph">You will notice some big changes in how fights play out. Destructible terrain lets you create cover or break through walls. The pickaxe helps with this, so you can change the battlefield on the fly. Gunplay feels smoother, with tweaks to weapons like the SCAR-L, AKM, Panzerfaust, and Mk12. These changes make fights more fair and fun.</p> 
                    <p class="otl-paragraph">Check out this chart to see which weapons players use most in tournaments:</p> 
                    <p class="otl-paragraph"><br /><img src="https://static-cdn.manabuy.com/wz_20250324103741/pubgm_20250324110852/pubg-mobile-new-season-update-steampunk-frontier-rewards_20250827102037/download_image_1_202508271025.webp" alt="" width="700" height="525" /></p> 
                    <p class="otl-paragraph">Teams that grab airdrop weapons win more often. Sniper rifles show up in most final circles. If you want to win, learn how to use the new tools and work with your squad. The new weapons and vehicles give you more ways to outplay your opponents.</p> 
                    <h2 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">PUBG Mobile Season Rewards</h2> 
                    <p class="otl-paragraph">The new season gives you some of the best rewards ever. You can get cool outfits, weapon skins, and rare vehicle finishes. The Royale Pass lets you unlock these items as you play and level up.</p> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Royale Pass</h3> 
                    <p class="otl-paragraph">There are three types of Royale Pass this season. Each one has different rewards and perks. Here is a quick guide:</p> 
                    <table class="outline-table" style="border-style: solid; border-width: 1px;" border="1"> 
                     <tbody> 
                      <tr> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="63"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Royale Pass Type</strong></span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="63"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Cost / Access</strong></span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="63"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Immediate Rewards (UC value)</strong></span></p> </td> 
                       <td style="width: 266.61764705882354px; max-width: 266.61764705882354px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="266.61764705882354" height="63"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Additional Benefits</strong></span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Elite Pass Plus</span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Paid, 40% off vs Elite Pass</span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">10,000 UC worth of rewards</span></p> </td> 
                       <td style="width: 266.61764705882354px; max-width: 266.61764705882354px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="266.61764705882354" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Grants 25 ranks immediately, includes Elite Pass rewards</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="63"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Elite Pass</span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="63"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">300 UC</span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="63"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">4,000 UC worth of rewards</span></p> </td> 
                       <td style="width: 266.61764705882354px; max-width: 266.61764705882354px; height: 63px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="266.61764705882354" height="63"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Faster ranking via elite missions</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Free Pass</span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Free to all players</span></p> </td> 
                       <td style="width: 157.7941176470588px; max-width: 157.7941176470588px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="157.7941176470588" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">N/A</span></p> </td> 
                       <td style="width: 266.61764705882354px; max-width: 266.61764705882354px; height: 81px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="266.61764705882354" height="81"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Earn Royale Points from missions, crates, events</span></p> </td> 
                      </tr> 
                     </tbody> 
                    </table> 
                    <p class="otl-paragraph">You earn Royale Points by doing daily and weekly missions. You also get points from crates and events. If you reach the top rank, you get 600 UC back for next season’s pass. The Elite Pass track gives rewards worth up to 40,000 UC. This is a great deal for players who play a lot.</p> 
                   </div> 
                   <div> 
                    <div> 
                     <div> 
                      <blockquote style="padding-left: 1em; text-indent: 0em;">
                       Tip: You can&nbsp;
                       <a class="hyperlink" href="https://manabuy.com/blog/pubg-mobile-uc-safe-top-up-guide" target="_blank" rel="noopener">recharge your UC</a>&nbsp;easily with ManaBuy. It is safe and fast. You get instant UC, secure payments, and up to 16% off. ManaBuy has 24/7 support and many ways to pay. You will not miss out on rewards.
                      </blockquote> 
                     </div> 
                    </div> 
                   </div> 
                   <div> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Legendary Items</h3> 
                    <p class="otl-paragraph">This season’s rewards have a spooky Halloween theme. You can unlock legendary and mythic items as you level up. Here are some of the best rewards:</p> 
                    <table class="outline-table" style="border-style: solid; border-width: 1px;" border="1"> 
                     <tbody> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Level</strong></span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Reward Type</strong></span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Item Name / Description</strong></span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="text-align: center; margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px; font-weight: bold;"><strong>Notes</strong></span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">1</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Outfit</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">P-sycho Nurse Set (female) + headgear</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">White and red colored outfit</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">5</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Weapon Skin</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">PP-19 Bizon SMG finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Dark tone</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">15</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Vehicle Finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Airplane finish with spider-web and skulls vibe</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Name not specified</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">20</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Helmet Finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Sugarspell Curse Helmet</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Black and orange, Halloween pumpkin theme</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">30</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Weapon Finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Jester – S1897 (S1897 shotgun)</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="--font-size: 13px; margin-bottom: 0px;">&nbsp;</p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">50</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Mythic Outfit + Weapon</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Aberrant Surgeon Set + Sugarspell Curse – Dual MP7</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Mad doctor theme, upgradable weapon</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">60</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Vehicle Finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Sugarspell Curse – UTV</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Livik map exclusive</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">80</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Epic Weapon Finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">M416 AR finish + Molotov Cocktail finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 45px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="45"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Free RP path</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">90</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Weapon Finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">AKM finish</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Highly requested by players</span></p> </td> 
                      </tr> 
                      <tr> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">100</span></p> </td> 
                       <td class="unable-show-para-btn" style="width: 137.56410256410257px; max-width: 137.56410256410257px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="137.56410256410257" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Legendary Outfit Set</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Sugarspell Curse Set (female)</span></p> </td> 
                       <td style="width: 232.43589743589743px; max-width: 232.43589743589743px; height: 27px; vertical-align: middle; border-width: 1px; border-style: solid;" colspan="1" rowspan="1" align="left" valign="middle" width="232.43589743589743" height="27"> <p class="otl-paragraph" style="margin-top: 0px; margin-bottom: 0px;"><span class="color_font" style="font-size: 13px;">Mysterious witch with magical powers</span></p> </td> 
                      </tr> 
                     </tbody> 
                    </table> 
                    <p class="otl-paragraph">You also get special items like the Spooky Pumpkin Frag Grenade. There is also the Green Vines Buggy Finish. The new mythic and legendary skins have cool animations and effects. These skins are more rare than before.</p> 
                    <br />
                    <img src="https://static-cdn.manabuy.com/wz_20250324103741/pubgm_20250324110852/pubg-mobile-new-season-update-steampunk-frontier-rewards_20250827102037/download_image_2_202508271025.webp" alt="" width="700" height="525" />
                    <br /> 
                    <p class="otl-paragraph">If you want to save UC, pick the best pass and use ManaBuy discounts. This helps you get more rewards for less money. You can enjoy every match with new looks and gear.</p> 
                    <p class="otl-paragraph">You get so much new stuff this season. Players love the Unfail Horror Mode for its fast 4v1 action, special survivor tools, and the predator’s Rage powers. The new maps feel tense and exciting with electric barriers and smoke. You also see better graphics and fun events like Spooky Soiree. ManaBuy helps you grab top-ups fast, so you can unlock rewards and try every feature. What’s your favorite part of the update? Drop your thoughts in the comments!</p> 
                    <h2 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">FAQ</h2> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">How do you unlock the new Steampunk Frontier map?</h3> 
                    <p class="otl-paragraph">You just need to update PUBG Mobile to version 4.0. After that, you can select Steampunk Frontier from the map list. Jump in and start exploring all the new features right away!</p> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">What is the Magic Broom, and how do you use it?</h3> 
                    <p class="otl-paragraph">The Magic Broom is a flying vehicle. You can find it on the Steampunk Frontier map. Hop on with a teammate, fly across the map, and use the Sweep Attack to knock back enemies. It’s great for fast travel and surprise attacks.</p> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Can you get the new legendary skins without buying the Royale Pass?</h3> 
                    <p class="otl-paragraph">You can earn some free rewards by completing missions and leveling up. However, the best legendary and mythic skins are only available through the paid Royale Pass tracks. Want to unlock them faster? Use <a class="hyperlink" href="https://manabuy.com/pubg-mobile-top-up" target="_blank" rel="noopener">ManaBuy for discounted UC top-ups</a>.</p> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">What are Steam Coins, and how do you spend them?</h3> 
                    <p class="otl-paragraph">Steam Coins are a special currency on the Steampunk Frontier map. You earn them by riding trains, opening crates, or completing tasks. Spend them at Clockwork Merchants for buffs, gear, or special drinks.</p> 
                    <h3 class="otl-heading" style="text-indent: 0em; padding-left: 0em;">Is ManaBuy safe for topping up PUBG Mobile UC?</h3> 
                    <p class="otl-paragraph">Yes! <a class="hyperlink" href="https://manabuy.com/pubg-mobile-top-up" target="_blank" rel="noopener">ManaBuy offers secure payments</a>, instant UC delivery, and 24/7 support. Many players trust ManaBuy for fast and affordable top-ups. You can join their Discord community for extra deals and updates.</p> 
                   </div> 
                  </div>
                 </body>
                </html>
                """
            )
            .forceColorSchemeBackground(true)
            .linkOpenType(.Safari)
            .padding()
        }
    }
}
