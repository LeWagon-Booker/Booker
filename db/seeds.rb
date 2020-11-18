require 'faker'
require "open-uri"

puts "Cleaning up the DB"
 Review.destroy_all
 Adhesion.destroy_all
 Family.destroy_all
 Reservation.destroy_all
 Book.destroy_all
 Category.destroy_all
 User.destroy_all
puts "          ... done!"

puts "Creating Users"
  User.create!( email: 'olivier@dotreppe.be',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'Olivier',
    last_name: "d'Otreppe",
    username: "odotreppe",
    ).avatar.attach(io: URI.open("https://avatars3.githubusercontent.com/u/11991244?v=4"), filename: 'avatar.jpg', content_type: 'image/jpg')
  User.create!( email: 'ScottvanStrydonck@gmail.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'Scott',
    last_name: "Van Strydonck",
    username: "scottvanstrydonck"
    ).avatar.attach(io: URI.open("https://avatars2.githubusercontent.com/u/71709801?v=4"), filename: 'avatar.jpg', content_type: 'image/jpg')

  User.create!( email: 'Lex.Radj@gmail.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'Lex',
    last_name: "Radj",
    username: "lexradj"
    ).avatar.attach(io: URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1601370359/fhlao5go9y2ak4uqxzb6.jpg"), filename: 'avatar.jpg', content_type: 'image/jpg')

  User.create!( email: 'thibault.a@hotmail.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'Thibault',
    last_name: "Alexandre",
    username: "thibaultalexandre"
    ).avatar.attach(io: URI.open("https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1603807623/rkkm2rsclqznydbt7rxb.jpg"), filename: 'avatar.jpg', content_type: 'image/jpg')

  User.create!( email: 'Charles.delalaing@gmail.com',
    password: '123456',
    password_confirmation: '123456',
    first_name: 'Charles',
    last_name: "de Lalaing",
    username: 'charles.delalaing'
    ).avatar.attach(io: URI.open("https://avatars3.githubusercontent.com/u/71701904?v=4"), filename: 'avatar.jpg', content_type: 'image/jpg')
puts "          ... done!"

puts 'Creating catergories...'
  CATEGORIES = %w[Fantasy Adventure Romance Contemporary Dystopian Mystery Horror Thriller Paranormal Science-Fiction Cooking Art Personal Motivational Health History Travel Humor Children’s Business Entrepreneurship Manga BD Comic"]
  CATEGORIES.each { |category| Category.create(name: category) }
puts "          ... done!"

puts 'Your library is loading...'
  Book.create(

    title: "Twilight and Dawn",
    author: "Ken Follett",
    description:  "Before The Pillars of the Earth... In the year 997, at the end of the High Middle Ages, the British faced attacks by Vikings threatening to invade the country. In the absence of a rule of law, it is the reign of chaos. nIn this tumultuous period, the destinies of three characters intersect. The young Edgar, boat builder, sees his life change when his house is destroyed during a Viking raid. Ragna, a young, rebellious Norman nobleman, married the Englishman Wilwulf out of love, but the customs of his adopted country were scandalously different from his own. Aldred, an idealistic monk, dreams of transforming his modest abbey into a world-renowned centre of scholarship. Each of them will stand in the way of Bishop Wynstan’s life, ready to do anything to increase his wealth and strengthen.",
    year: 2020,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://media.standaardboekhandel.be/-/media/mdm/product/9782221157701/frontImagesLink.img?rev=2451225236&w=525&hash=A881EB5495E8A08D7D672653E35223C5"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Holes",
    author: "Louis Sachar",
    description:  "Holes is a 1998 young adult novel written by Louis Sachar and first published by Farrar, Straus and Giroux. The book centers on an unlucky teenage boy named Stanley Yelnats, who is sent to Camp Green Lake, a juvenile detention center in a desert in Texas, after being falsely accused of theft.",
    year: 1998,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://media.s-bol.com/JVY4qL3ZGz2/781x1200.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Sapiens",
    author: "Yuval Noah Harari",
    description:  "What does it mean to be human? In a sweeping narrative spanning two and half million years of human evolution, Israeli historian Yuval Noah Harari weaves insights from science and the humanities together to answer to what it means to be human.",
    year: 2014 ,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://brandgenetics.com/wp-content/uploads/2019/11/Sapiens.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Wolf Hall",
    author: "Hilary Mantel",
    description:  "'Lock Cromwell in a deep dungeon in the morning,' says Thomas More, 'and when you come back that night he'll be sitting on a plush cushion eating larks' tongues, and all the gaolers will owe him money.' England, the 1520s. Henry VIII is on the throne, but has no heir. Cardinal Wolsey is his chief advisor, charged with securing the divorce the pope refuses to grant. Into this atmosphere of distrust and need comes Thomas Cromwell, first as Wolsey's clerk, and later his successor. Cromwell is a wholly original man: the son of a brutal blacksmith, a political genius, a briber, a charmer, a bully, a man with a delicate and deadly expertise in manipulating people and events. Ruthless in pursuit of his own interests, he is as ambitious in his wider politics as he is for himself. His reforming agenda is carried out in the grip of a self-interested parliament and a king who fluctuates between romantic passions and murderous rages. From one of our finest living writers, Wolf Hall is that very rare thing: a truly great English novel, one that explores the intersection of individual psychology and wider politics. With a vast array of characters, and richly overflowing with incident, it peels back history to show us Tudor England as a half-made society, moulding itself with great passion, suffering and courage. ",
    year: 2010,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/51buA9khcPL._SX329_BO1,204,203,200_.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "stairway: Book II",
    author: "Zecharia Sitchin",
    description:  "Since earliest times, human beings have pondered the incomprehensible questions of the universe, life . . . and the afterlife. Where did mortal man go to join the immortal Gods? Was the immense and complex structure at Giza an Egyptian Pharaoh's portal to immortality? Or a pulsating beacon built by extraterrestrials for landing on Earth? In this second volume of his trailblazing series The Earth Chronicles, Zecharia Sitchin unveils secrets of the pyramids and hidden clues from ancient times to reveal a grand forgery on which established Egyptology is founded, and takes the reader to the Spaceport and Landing Place of the Anunnaki gods— Those Who from Heaven to Earth Came.",
    year: 2007,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/513MJX2NNwL._SX307_BO1,204,203,200_.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Bind, Torture, Kill",
    author: "Roy Wenzl, Tim Potter, Hurst Laviana, L. Kelly",
    description:  "For thirty-one years, a monster terrorized the residents of Wichita, Kansas. A bloodthirsty serial killer, self-named BTK—for bind them, torture them, kill them—he slaughtered men, women, and children alike, eluding the police for decades while bragging of his grisly exploits to the media. The nation was shocked when the fiend who was finally apprehended turned out to be Dennis Rader—a friendly neighbor . . . a devoted husband . . . a helpful Boy Scout dad . . . the respected president of his church. ",
    year: 2008,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/51-1GV1227L._SX307_BO1,204,203,200_.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Barbarian Days: A Surfing Life",
    author: "William Finnegan ",
    description:  "Surfing only looks like a sport. To devotees, it is something else entirely: a beautiful addiction, a mental and physical study, a passionate way of life. New Yorker writer William Finnegan first started surfing as a young boy in California and Hawaii. Barbarian Days is his immersive memoir of a life spent travelling the world chasing waves through the South Pacific, Australia, Asia, Africa and beyond. Finnegan describes the edgy yet enduring brotherhood forged among the swell of the surf; and recalling his own apprenticeship to the world's most famous and challenging waves, he considers the intense relationship formed between man, board and water.",
    year: 2016,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/51Mn7NOBP1L._SX316_BO1,204,203,200_.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Mr. Sunset",
    author: "Phil Jarratt",
    description:  "The history of modern 60's/70's surfing from the life of Hakman. A Californian raised surfer who moved to Hawaii & travelled the world during the 60's & 70's living the life of a surfer and a finding ways to make enough money to continue his surfing lifestyle. Professional surfing was growing but not yet organized enough as a sport to make a year round living from surfing alone. Because of this Hakman tried a lot of different businesses both legal and illegal. The amount of business ventures he started and places he lived is incredible! So much unending energy he had to do all that was likely why outside of surfing consequential waves it so challenging for Jeff to stay focused on land.",
    year: 1997,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/71E0REBFNKL._SX404_BO1,204,203,200_.gif"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "The Pilgrimage: 50 Places to Surf Before You Die",
    author: "Sean Doherty",
    description:  "This book is sure to become a classic. The text creates a great sense of place, and there's practical information on getting to (nearly) every break, the best time to go, what to take, where to stay, and what to look out for. The Pilgrimage is the perfect read for anyone who has ever caught, or tried to catch, a wave, from grommets to geriatrics. Destinations include:Australia and New Zealand, Indonesia and southern Asia, the north and south Pacific Africa and the Indian Ocean, Europe and Great Britain North and South America.",
    year: 2014,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/41TJJwKrw4L._SX439_BO1,204,203,200_.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "The Disposable Skateboard Bible",
    author: "Sean Cliver",
    description:  "With the release of Disposable - A History of Skateboard Art in 2004, author Sean Cliver made a brilliant attempt at artfully cataloging every important skateboard deck ever released. In the process, he created a classic, but was left feeling less than satisfied. Ever the completist, the gaping omissions in the first book gnawed at him and drove him to envision compiling the ultimate encyclopedia of Skateboard decks. While Disposable was beautiful, capturing the essence of the aesthetic, The Disposable Skateboard Bible sets out to be the ultimate guide. The author's industry insider status (in 1989 he landed his first job as a designer at Powell-Peralta) allows him to guide readers through the culture and experience, the art and the mania of the skate world with authority and expertise. While the boards take center stage, fascinating vignettes and recollections by an A-list of skateboarding personalities from Tony Hawk to Mike Vallely, Mark Gonzales to Stacy Peralta and more.",
    year: 2009,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/51cP5BibznL._SX417_BO1,204,203,200_.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Skateboarding and the City",
    author: "Iain Borden",
    description:  "Skateboarding is both a sport and a way of life. Creative, physical, graphic, urban and controversial, it is full of contradictions a billion-dollar global industry which still retains its vibrant, counter-cultural heart. Skateboarding and the City presents the only complete history of the sport, exploring the story of skate culture from the surf-beaches of 60s California to the latest developments in street-skating today. Written by a life-long skater who also happens to be an architectural historian, and packed through with full-colour images of skaters, boards, moves, graphics, and film-stills this passionate, readable and rigorously-researched book explores the history of skateboarding and reveals a vivid understanding of how skateboarders, through their actions, experience the city and its architecture in a unique way.",
    year: 2019,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/51bPx-QtlSL._SX401_BO1,204,203,200_.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"

  Book.create(
    title: "Coding For Dummies",
    author: "Nikhil Abraham",
    description:  "No coding experience is required for Coding For Dummies, your one-stop guide to building a foundation of knowledge in writing computer code for web, application, and software development. It doesn't matter if you've dabbled in coding or never written a line of code, this book guides you through the basics.",
    year: 2015,
    category: Category.all.sample(),
    ).cover.attach(io: URI.open("https://images-na.ssl-images-amazon.com/images/I/51q-YHB62GL.jpg"), filename: 'cover.png', content_type: 'image/png')
    BookOwnership.create!(user: User.all.sample, book: Book.last)
    puts "    Book ID: #{Book.last.id} - #{Book.last.title} Created"
puts "          ... done!"

puts 'Creating reservations'
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('15/11/2020'), end_date: Date.parse('16/11/2020'), message: "I would love to borrow this book")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('17/11/2020'), end_date: Date.parse('18/11/2020'), message: "this book look nice, can I borrow it?")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('19/11/2020'), end_date: Date.parse('20/11/2020'), message: "Long time I have searched for this one!")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('21/11/2020'), end_date: Date.parse('22/11/2020'), message: "I like the first one of the serie, i would love to read this one")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('23/11/2020'), end_date: Date.parse('24/11/2020'), message: "I would love to borrow this book")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('25/11/2020'), end_date: Date.parse('26/11/2020'), message: "This might be interesting to read.")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('27/11/2020'), end_date: Date.parse('28/11/2020'), message: "I would love to borrow this book")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('29/11/2020'), end_date: Date.parse('30/11/2020'), message: "this book look nice, can I borrow it?")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('01/12/2020'), end_date: Date.parse('02/12/2020'), message: "Long time I have searched for this one!")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('03/12/2020'), end_date: Date.parse('04/12/2020'), message: "I like the first one of the serie, i would love to read this one")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('05/12/2020'), end_date: Date.parse('06/12/2020'), message: "Awesome")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('07/12/2020'), end_date: Date.parse('08/12/2020'), message: "I would love to borrow this book")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('09/12/2020'), end_date: Date.parse('10/12/2020'), message: "this book look nice, can I borrow it?")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('11/12/2020'), end_date: Date.parse('12/12/2020'), message: "I like the first one of the serie, i would love to read this one")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('13/12/2020'), end_date: Date.parse('14/12/2020'), message: "I would love to borrow this book")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('15/12/2020'), end_date: Date.parse('16/12/2020'), message: "This might be interesting to read.")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('17/12/2020'), end_date: Date.parse('18/12/2020'), message: "I would like to read this")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('19/12/2020'), end_date: Date.parse('20/12/2020'), message: "Awesome")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('21/12/2020'), end_date: Date.parse('22/12/2020'), message: "I would love to borrow this book")
  Reservation.create!(user: User.all.sample, book: Book.all.sample , start_date: Date.parse('23/12/2020'), end_date: Date.parse('24/12/2020'), message: "Share this book with me please")
puts "          ... done!"

puts 'Creating families'
  Family.create(name: "Let's read!").picture.attach(filename: 'family.jpg', io: URI.open("https://res.cloudinary.com/bestycame/image/upload/v1605282752/0686qk1cx34ozpre8f0u7y31gs0p.jpg"))
  Family.create(name: "Bxl's old ladies").picture.attach(filename: 'family.jpg', io: URI.open("https://res.cloudinary.com/bestycame/image/upload/v1605705266/index_cwpjl8.jpg"))
  Family.create(name: "Brussels reading group!").picture.attach(filename: 'family.jpg', io: URI.open("https://res.cloudinary.com/bestycame/image/upload/v1605705325/bru_o6oyit.jpg"))
  Family.create(name: "Namur's church of scientology reading group")
puts "          ... done!"

puts 'creating adhesions'
  Family.all[1..].each { |family| User.all.sample(rand(1..3)).each { |user| Adhesion.create!(user: user, family: family) } }
  User.all.each { |user| Adhesion.create!(user: user, family: Family.all.first) }
puts "          ... done!"

puts 'creating book reviews'
  gd = ["I absolutely LOVED it !", "Very sweet lecture", "If I could have given it 10 stars I would have done it for sure !", "simply perfect, the way the story is given to you and the charismatic caracters defenitely puts this book in my favorite list !", "I ain't got more to say, just read the other comments...", "I randomly found this book in my library, it's just great great great!", "The crème of la crème!", "super dope, loved it dude, keep it real.", "It was good, the writting was easy to follow and I quickly fell for it.", "I couldn't stop reading it!! I am so obsessed with Johnny, he is sooo charismatic, I recommend it for dayyys!!", "I am going to tattoo the book cover on my chest so I can always remember that I read it and that is was a good one !"]
  av = ["Not has good as I tought", "It was very good but the end was a bit 'sloppy'", "It was like having a picnic with Adam and Eve", "sweet and sour", "Quitte good, bt not great", "Very thrilling and smooth reading", "I saw a spelling mistake in the book, if you find it, I will give you 100 euros worth of garlic", "very clever ending, I recommend it to anyone who hasn't really been into reading for a while.", "Ok is all i gotta say about this 'oeuvre'"]
  bd = ["I did not like this book", "Yeah but Nah..", "Bad from line one to the trash", "Oh Hell no no way anyone should read this piece of garbage", "People who like this book have shitty taste !", "nope, good start but terrible ending in my opinion", "Not worth reading", "BAD !", "I recommend it to anyone that is blind", "I liked the cover but the story was awful..", "Naaaah, the critics are over the roof and I don't get why people get so offended when I say I dislike the book, it is simply bad.", "Boring Alert !", "It's childish"]
  10.times { Review.create(user: User.all.sample, book: Book.all.sample, rating: rand(1..2), content: bd.sample) }
  10.times { Review.create(user: User.all.sample, book: Book.all.sample, rating: rand(3..4), content: av.sample) }
  10.times { Review.create(user: User.all.sample, book: Book.all.sample, rating: 5         , content: gd.sample) }
puts "          ... done!"
