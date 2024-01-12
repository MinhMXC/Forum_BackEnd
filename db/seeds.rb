Viewed.destroy_all
CommentsLike.destroy_all
CommentsDislike.destroy_all
PostsLike.destroy_all
PostsDislike.destroy_all
PostTag.destroy_all
Comment.destroy_all
Tag.destroy_all
Post.destroy_all
User.destroy_all
ActiveRecord::Base.connection.execute("TRUNCATE TABLE vieweds, comments_likes, comments_dislikes, posts_likes, posts_dislikes, comments, posts, post_tags, tags, users RESTART IDENTITY")

Tag.create!({ tag_text: "Random", colour: "#edeff1" })
Tag.create!({ tag_text: "Anime", colour: "#c40000" })
Tag.create!({ tag_text: "Manga", colour: "#f06305" })
Tag.create!({ tag_text: "Light Novel", colour: "#f0aa05" })
Tag.create!({ tag_text: "Green Text", colour: "#778835" })
Tag.create!({ tag_text: "Technology", colour: "#05b1f0" })
Tag.create!({ tag_text: "Gaming", colour: "#f0aa05" })
Tag.create!({ tag_text: "Plants", colour: "#05f03c" })
Tag.create!({ tag_text: "Skincare", colour: "#9a05f0" })
Tag.create!({ tag_text: "Dark Humour", colour: "#000000" })
Tag.create!({ tag_text: "Programming", colour: "#bae302" })
Tag.create!({ tag_text: "Books", colour: "#543902" })
Tag.create!({ tag_text: "Movies", colour: "#016e6a" })
Tag.create!({ tag_text: "Music", colour: "#6e0149" })
Tag.create!({ tag_text: "Science", colour: "#5d02a3" })

User.create!({
  provider: "email",
  uid: "bruh@gmail.com",
  email: "bruh@gmail.com",
  password: "123456",
  allow_password_change: true,
  username: "minhmxc",
  bio: "Hi, welcome to my Forum",
  image: "data:image/jpeg;base64,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"
})

def create_post(n)
  title = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
  text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce blandit, sem nec pulvinar gravida, sapien dui placerat sem, id malesuada libero elit sed sem. Morbi ultricies augue sed arcu tempor egestas. Nulla porta neque eget ullamcorper ullamcorper. Phasellus congue lorem purus, ut posuere sapien ultricies aliquet. Integer aliquam fermentum iaculis. Donec maximus sem ut fringilla pellentesque. Morbi feugiat nisi nec felis pharetra, sed porta mauris bibendum. Nunc elit nunc, sodales sed placerat eu, maximus vel metus. Aenean a finibus eros. Nunc ut purus egestas orci consectetur egestas. Quisque laoreet molestie sapien et euismod. Suspendisse tincidunt viverra sapien ac rhoncus. Donec maximus fringilla mattis."

  for i in 1..n
    post = Post.create!({ title: title, body: text, user_id: 1, tag_ids: [1, 2, 3] })
    comment1 = Comment.create!( {  body: text,  user_id: 1,  post: post })
    comment2 = Comment.create!( {  body: text,  user_id: 1,  post: post, comment: comment1 })
    Comment.create!([ {body: text, user_id: 1, post: post}, {body: text, user_id: 1, post: post, comment: comment1}, {body: text, user_id: 1, post: post, comment: comment2}, ])
  end
end

create_post(2)

Post.create!({
  title: "Gotoubun no Hanayome Best Anime",
  body: ".",
  image: "https://images7.alphacoders.com/126/1262463.jpg",
  user_id: 1,
  tag_ids: [2]
})

Post.create!({
  title: "Elfen Lied Best Manga",
  body: ".",
  image: "https://royumi.com/cdn/shop/articles/elfen_lied_01.jpg?v=1683683706",
  user_id: 1,
  tag_ids: [3]
})

Post.create!({
  title: "Sevens Best Light Novel",
  body: ".",
  image: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/d99d9d8b-0a39-4f7a-b561-b8ea33173646/dag5y6f-fa66542f-0b8b-4b95-a69e-42354609669e.jpg/v1/fill/w_900,h_507,q_75,strp/wallpaper_of_lyle_waltz_from_sevens_1366x768_by_gameriuxlt_dag5y6f-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NTA3IiwicGF0aCI6IlwvZlwvZDk5ZDlkOGItMGEzOS00ZjdhLWI1NjEtYjhlYTMzMTczNjQ2XC9kYWc1eTZmLWZhNjY1NDJmLTBiOGItNGI5NS1hNjllLTQyMzU0NjA5NjY5ZS5qcGciLCJ3aWR0aCI6Ijw9OTAwIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.G1AWftt3prb4HWZK7fzn9EF1UiyR9EPMyyYzQ-w2Hj4",
  user_id: 1,
  tag_ids: [4]
})

Post.create!({
  title: "Today I avenged you, /b/rothers. Today I friendzoned the friendzoner",
  body: ">be me 24
         >me and GF fight, break up
         >know a new girl
         >very interesting, beautiful engineer
         >fall in love
         >girl say i'm perfect become intimate friends
         >she knows I like her, but don't want anything with me
         >tells me about every guy she fucks
         >feelsbadman.jpg
         >one day she gets drunk and we fuck, shew says it's a one night thing
         >she lie to all our friends we never even kissed
         >'he's like a brother'
         >2 months later me and ex GF talk, make things work
         >i'm happy now
         >new girl jelly
         >ask me out, wants to go to a motel
         >want me to be her boyfriend
         >'no'
         >'why, anon?'
         >'I love you, you're like a sister to me'",
  image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxm8hG85kbeI4UowXSkPVnricTDLd6N3QC2H9QPSj7qg&s",
  user_id: 1,
  tag_ids: [5]
})

Post.create!({
  title: "Man wins best female streamer using AI",
  body: "https://www.youtube.com/@Neurosama",
  image: "https://i.redd.it/neuro-sama-the-ai-vtuber-becomes-the-number-1-female-v0-dd7jlu6bpa9c1.png?width=1487&format=png&auto=webp&s=8fb3546af898981d6798797ab8d765e61d580c14",
  user_id: 1,
  tag_ids: [6]
})

Post.create!({
  title: "Tales of Berseria Best JRPG",
  body: ".",
  image: "https://image.api.playstation.com/vulcan/img/rnd/202009/2914/5gOz2iTDNShvwY4Go4kjjLsu.jpg",
  user_id: 1,
  tag_ids: [7]
})

Post.create!({
  title: "How to grow weed",
  body: "1. Buy weed from your friendly local drugs dealer\n2. Plant said weeds\n3. Water everyday\n4. Put up privacy fences to make sure no one finds out\n5. Sell your weed for unlimited money glitch",
  image: "https://t3.ftcdn.net/jpg/03/80/27/88/360_F_380278806_hU362lmcYRqkb8reIageNj4Qh7ID9mIg.jpg",
  user_id: 1,
  tag_ids: [8]
})

Post.create!({
  title: "My morning and night routine",
  body: "AM / PM: Cerave Hydrating Facial Cleanser + Innisfree Green Tea Seed Hyaluronic Cream.",
  user_id: 1,
  tag_ids: [9]
})

Post.create!({
  title: "What's the similarity between children with cancer and dark jokes?",
  body: "They never grow old",
  user_id: 1,
  tag_ids: [10]
})

Post.create!({
  title: "What has this programmer life bring me?",
  body: "Nothing but pain and misery. Occasional imposter syndrome. Money where?",
  user_id: 1,
  tag_ids: [11]
})

Post.create!({
  title: "Minecraft's New Official Guide Book",
  body: ".",
  image: "https://api.time.com/wp-content/uploads/2015/12/mein-kampf.jpg",
  user_id: 1,
  tag_ids: [12]
})

Post.create!({
  title: "Lord of The Rings Best Movie",
  body: ".",
  image: "https://variety.com/wp-content/uploads/2015/12/lordrings.jpg",
  user_id: 1,
  tag_ids: [13]
})

Post.create!({
  title: "Stay With Me Best Song",
  body: "https://www.youtube.com/watch?v=QNYT9wVwQ8A",
  user_id: 1,
  tag_ids: [14]
})

Post.create!({
  title: "How to make Methamphetamine",
  body: "Making Methamphetamine at home:

List of chemicals and materials: Diluted HCl - also called Muriatic acid - can be obtained from hardware stores, in the pool section

NaOH - also called lye

Ethyl Ether - aka Diethyl Ether - Et-0-Et - can be obtained from engine starting fluid, usually from a large supermarket. Look for one that says 'high ethyl ether content', such as Prestone

Ephedrine The cottons in todays vicks nasle inhalers dont contain efed or pfed (ephedrin or psuedoephedrin) but there are still lots of easy ways to get good ephed or pfed, pure ephedrin can be extracted out of it's plant matter, from a plant that can be bought at most garden stores. Or you can get pfed from decongestive pills like sudafed. Most people perfer to work with pfed from pills rather then ephed from the plant. The important thing is that you must have pure pfed/ephed as any contaminants will fuck up the molar ratio leaving you with over-reduced shit or under-reduced shit. Or contaminats will jell durring baseifying and gak up your product which will then be very hard to clean. So you want to find a pill that is nearly pure pfed hcl, or as close to pure as you can get. Also check the lable on your pills and see what inactive ingredients they contain. Inactive ingredients are things like binders and flavors. These you dont want and will remove when cleaning your pills. but certain inactive ingredients are harder to remove then others. You dont want pills with a red coating, you dont want pills with alot of cellose in them and you dont want pills with much wax. you also dont want pills that contain povidone. As a rule, if you have a two pills that contain the same amount of pfed hcl then take the smaller sized pill because it obviously has less binders and inactive ingredients, time released pills are usualy harder to work with because they have more binders and tend to gel up durring the a/b stage. Also only buy pills that have pfed hcl as the only active ingredient. You first have to make ephedrine (which is sometimes sold as meth by itself):If you are selling it...I would just make ephedrine and say it's meth.

Distilled water - it's really cheap, so you have no reason to use the nasty stuff from the tap. Do things right.

List of equipment : A glass eyedropper

Three small glass bottles with lids (approx. 3 oz., but not important)one should be marked at 1.5oz, use tape on the outside to mark it (you might want to label it as ether). One should be clear (and it can't be the marked one).

A Pyrex dish (the meatloaf one is suggested)

A glass quart jar

Sharp scissors

Clean rubber gloves

Coffee filters

A measuring cup

Measuring spoons

Preparing your Lab:

Preparing Ethyl Ether: WARNING: Ethyl Ether is very flammable and is heavier than air. Do not use ethyl ether near flame or non-sparkless motors. It is also an anaesthetic and can cause respiratory collapse if you inhale too much.

Take the unmarked small bottle and spray starter fluid in it until it looks half-full. Then fill the rest of the way with water, cap the bottle and shake for 5 minutes. Let it sit for a minute or two, and tap the side to try and separate the clear upper layer. Then, draw off the top (ether) layer with the eyedropper, and throw away the lower (water) and cloudy layer. Place the ether in the marked container. Repeat this until you have about 1.5 oz. of ether. Put the cap on it, and put it in the freezer if you can. Rinse the other bottle and let it stand.

Ethyl ether is very pungent. Even a small evaporated amount is quite noticeable.

Ephedrine & or P-Ephedrine: Please discuss this on the neonjoint forum

5. Pour 1/8 teaspoon of the lye crystals into the bottle of ephedrine and agitate. Do this carefully, as the mixture will become hot, and give off hydrogen gas and/or steam. H2 gas is explosive and lighter than air, avoid any flames as usual. Repeat this step until the mixture remains cloudy. This step neutralizes the HCl in the salt, leaving the insoluble free base (l-desoxyephedrine) again. Why do we do this? So that we can get rid of any water-soluble impurities. For 3 oz. bottles, this should take only 3 repetitions or so.

6. Fill the bottle from step 5 up the rest of the way with ethyl ether. Cap the bottle, and agitate for about 8 minutes. It is very important to expose every molecule of the free-base to the ether for as long as possible. This will cause the free base to dissolve into the ether (it -is- soluble in ether).

7. Let the mixture settle. There will be a middle layer that is very thick. Tap the side of the bottle to get this layer as thin as possible. This is why this bottle should be clear.

8. Remove the top (ether) layer with the eyedropper, being careful not to get any of the middle layer in it. Place the removed ether layer into a third bottle.

9. Add to the third bottle enough water to fill it half-way and about 5 drops of muriatic acid. Cap it. Shake the bottle for 2 minutes. When it settles, remove the top layer and throw it away. The free base has now been bonded to the HCl again, forming a water soluble salt. This time, we're getting rid of ether-soluble impurities. Make sure to get rid of all the ether before going to step 11!

10. If there is anything left from step 3, repeat the procedure with it.

11. Evaporate the solution in the Pyrex dish on low heat. You can do this on the stove or nuke it in the microwave (be careful of splashing), but I have found that if you leave it on top of a hot-water heater (like the one that supplies hot water to your house) for about 2-3 days, the remaining crystals will be ephedrine HCl.

If you microwave it, I suggest no more than 5-10s at one time. If it starts 'popping', that means you have too little liquid left to microwave. You can put it under a bright (100W) lamp instead. Microwaving can result in uneven heating, anyway.

First Batch: 120mg ephedrine HClEstimated: 300mg (100% of theoretical, disregarding HCl)

Now, Making Methamphetamine out of ephedrine by reducing it with Hydroiodic Acid and Red Phosphorus.

Items needed: Alot of matchbooks (the kind with the striking pad)

Coffee filters (or filter paper)

Something that measures ml and grams

A flask (a small pot with a lid can be used)

iodine

Hydroiodic Acid (I will tell you how to make this)

Red Phosphorus (I will tell you how to make this).",
  image: "https://www.narconon.org/FURL/imagecache/cropfit@w=710/blob/images/articles/2/c/2c48f7c7-4cd4-11e8-aab4-42010a80013d/methamphetamine-crystal.jpg",
  user_id: 1,
  tag_ids: [15]
})

