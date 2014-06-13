
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


###########     Create Rights       ################

rightUpload = Right.create(id:1, name:'Upload', is_available:true)
rightDownload = Right.create(id:2, name:'Download', is_available:true)
rightComment = Right.create(id:3, name:'Comment', is_available:true)

###########     Create Groups       ################
groupAM = Group.create(id:1, name:'4AM')
groupHepia = Group.create(id:2, name:'Hepia')
groupGuest = Group.create(id:3, name:'Guest')
groupVisitor = Group.create(id:4, name:'Visitor')

###########     Create link Group Rights        ################
groupAM.rights << rightUpload
groupAM.rights << rightDownload
groupAM.rights << rightComment

groupHepia.rights << rightUpload
groupHepia.rights << rightDownload

groupGuest.rights << rightDownload


###########     Create People       ################

admin = 'Admin'
user = 'User'
jayro = Person.create(id:1, lastname:'Aldaz', firstname:'Jayro', password:'jayro', password_confirmation:'jayro', email:'jayroaldaz@gmail.com', dateofbirth:'1988-01-02', private_phone:'077 654 45 35', professional_phone:'022 234 45 35', type:admin)
andres = Person.create(id:2, lastname:'Torres', firstname:'Andres', password:'andres', password_confirmation:'andres',email:'andrestorres@hotmail.com', dateofbirth:'1991-02-11', private_phone:'077 654 45 35', professional_phone:'022 234 45 35', type:user)
jean = Person.create(id:3, lastname:'Heer', firstname:'Jean', password:'jean', password_confirmation:'jean', email:'jeanheer@yahoo.fr', dateofbirth:'1885-07-16', private_phone:'076 654 45 35', professional_phone:'022 234 45 35', type:user)
edison = Person.create(id:4, lastname:'King', firstname:'Edison', password:'edison', password_confirmation:'edison', email:'edisonking@hotmail.com', dateofbirth:'2008-03-24', private_phone:'078 622 22 35', professional_phone:'021 234 45 35', type:user)
alexis = Person.create(id:5, lastname:'Gonzales', firstname:'Alexis', password:'alexis', password_confirmation:'alexis', email:'alexisgonzales@gmail.com', dateofbirth:'1845-05-06', private_phone:'079 654 45 35', professional_phone:'021 233 46 35', type:user)
alex = Person.create(id:6, lastname:'Clerc', firstname:'Alex', password:'alex', password_confirmation:'alex', email:'alexclerc@gmail.com', dateofbirth:'1885-04-04', private_phone:'078 654 88 77', professional_phone:'031 231 45 39', type:user)
pedro = Person.create(id:7, lastname:'Python', firstname:'Pedro', password:'pedro', password_confirmation:'pedro', email:'pedropython@gmail.com', dateofbirth:'1882-01-02', private_phone:'077 719 99 75', professional_phone:'031 213 54 95', type:user)
jacques = Person.create(id:8, lastname:'Abiéniste', firstname:'Jacques', password:'jacques', password_confirmation:'jacques', email:'jacquesabieniste@gmail.com', dateofbirth:'1875-12-31', private_phone:'076 804 49 65', professional_phone:'022 312 55 34', type:user)
christian = Person.create(id:9, lastname:'Albertinetti', firstname:'Christian', password:'christian', password_confirmation:'christian', email:'christianalbertinetti@hotmail.com', dateofbirth:'1991-01-02', private_phone:'077 994 25 55', professional_phone:'022 231 77 43', type:user)
oscar = Person.create(id:10, lastname:'Altorfer', firstname:'Oscar', password:'oscar', password_confirmation:'oscar', email:'oscaraltorfer@yahoo.com',  dateofbirth:'1989-12-27', private_phone:'079 274 55 30', professional_phone:'020 231 88 34', type:user)
jeremie = Person.create(id:11, lastname:'Rossier', firstname:'Jérémie', password:'jeremie', password_confirmation:'jeremie', email:'jeremierossier@hotmail.com', dateofbirth:'1987-05-02', private_phone:'078 874 35 31', professional_phone:'021 777 89 94', type:admin)
yannis = Person.create(id:12, lastname:'Marti', firstname:'Yannis', password:'yannis', password_confirmation:'yannis', email:'yannismarti@hotmail.com', dateofbirth:'1986-07-29', private_phone:'077 765 21 01', professional_phone:'021 567 77 09', type:admin)
paul = Person.create(id:13, lastname:'Albuquerque', firstname:'Paul', password:'paul', password_confirmation:'paul', email:'paulalbuquerque@hotmail.com', dateofbirth:'1982-09-02', private_phone:'077 987 15 30', professional_phone:'022 200 87 04', type:admin)
hepia = Person.create(id:14, lastname:'Hepia', firstname:'Hepia', password:'hepia', password_confirmation:'hepia', email:'hepia@gmail.com', dateofbirth:'1954-01-14', private_phone:'078 432 55 30', professional_phone:'031 132 18 81', type:user)
guest = Person.create(id:15, lastname:'Guest', firstname:'Guest', password:'guest', password_confirmation:'guest', email:'guest@gmail.com', dateofbirth:'1979-11-12', private_phone:'077 123 78 08', professional_phone:'021 291 16 12', type:user)
visitor = Person.create(id:16, lastname:'Visitor', firstname:'Visitor', password:'visitor', password_confirmation:'visitor', email:'visitor@gmail.com', dateofbirth:'1989-10-22', private_phone:'079 874 75 30', professional_phone:'021 263 33 34', type:user)


###########     Create links Groups Person      ################
jayro.groups << groupAM
jeremie.groups << groupAM
yannis.groups << groupAM

paul.groups << groupHepia
hepia.groups << groupHepia

andres.groups << groupGuest
jean.groups << groupGuest
edison.groups << groupGuest
alexis.groups << groupGuest
alex.groups << groupGuest
guest.groups << groupGuest

pedro.groups << groupVisitor
jacques.groups << groupVisitor
christian.groups << groupVisitor
oscar.groups << groupVisitor
visitor.groups << groupVisitor


###########     Create PersonalGroup        ################

Personalgroup.create(id:1, person_id:jayro.id)
Personalgroup.create(id:2, person_id:andres.id)
Personalgroup.create(id:3, person_id:jean.id)
Personalgroup.create(id:4, person_id:edison.id)
Personalgroup.create(id:5, person_id:alexis.id)
Personalgroup.create(id:6, person_id:alex.id)
personalGroupPedro = Personalgroup.create(id:7, person_id:pedro.id)
personalGroupJacques = Personalgroup.create(id:8, person_id:jacques.id)
personalGroupChristian = Personalgroup.create(id:9, person_id:christian.id)
personalGroupOscar = Personalgroup.create(id:10, person_id:oscar.id)
Personalgroup.create(id:11, person_id:jeremie.id)
Personalgroup.create(id:12, person_id:yannis.id)
Personalgroup.create(id:13, person_id:paul.id)
Personalgroup.create(id:14, person_id:hepia.id)
Personalgroup.create(id:15, person_id:guest.id)
personalGroupVisitor = Personalgroup.create(id:16, person_id:visitor.id)


###########     Add Rights To PersonalGroup

personalGroupPedro.rights << rightDownload

personalGroupJacques.rights << rightComment

personalGroupChristian.rights << rightDownload
personalGroupChristian.rights << rightComment

personalGroupOscar.rights << rightComment
personalGroupOscar.rights << rightUpload

personalGroupVisitor.rights << rightComment

###########     Create Video and his owner      ################
=begin
videoComposite = Videoitem.create(id:1, title:'Composite', description:'Pattern Composite' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/01%20Composite%20Pattern.mp4', person_id: jayro.id)
videoIntro = Videoitem.create(id:2, title:'Intro', description:'Introduction' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/01%20Intro.mp4', person_id: andres.id)
videoTemplateMethod = Videoitem.create(id:3, title:'Template Method', description:'Pattern Template Method' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/01%20Template%20Method%20Pattern.mp4', person_id: jeremie.id)
videoDecorator = Videoitem.create(id:4, title:'Decorator', description:'Pattern Decorator' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/02%20Decorator%20Pattern.mp4', person_id: jeremie.id)
videoSetup = Videoitem.create(id:5, title:'Setup', description:'Description Setup' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/02%20Project%20Setup.mp4', person_id: paul.id)
videoStrategy = Videoitem.create(id:6, title:'Strategy', description:'Pattern Strategy' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/02%20Strategy%20Pattern.mp4', person_id: jeremie.id)
videoObserver = Videoitem.create(id:7, title:'Observer', description:'Pattern Observer' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/03%20Observer%20Pattern.mp4', person_id: jayro.id)
videoProxy = Videoitem.create(id:8, title:'Proxy', description:'Pattern Proxy' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/03%20Proxy%20Pattern.mp4', person_id: jayro.id)
videoIterator = Videoitem.create(id:9, title:'Iterator', description:'Pattern Iterator' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/04%20Iterator%20Pattern.mp4', person_id: jayro.id)
videoCommand = Videoitem.create(id:10, title:'Command', description:'Pattern Command' , is_available:true, date:Time.now, views:0, pathvideo:'http://127.0.0.1/videosam/05%20Command%20Pattern.mp4', person_id: yannis.id)
=end

videoComposite = VideoClip.create(id:1, title:'Composite', description:'Pattern Composite' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/01%20Composite%20Pattern.mp4', person_id: jayro.id)
videoIntro = VideoClip.create(id:2, title:'Intro', description:'Introduction' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/01%20Intro.mp4', person_id: andres.id)
videoTemplateMethod = VideoClip.create(id:3, title:'Template Method', description:'Pattern Template Method' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/01%20Template%20Method%20Pattern.mp4', person_id: jeremie.id)
videoDecorator = VideoClip.create(id:4, title:'Decorator', description:'Pattern Decorator' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/02%20Decorator%20Pattern.mp4', person_id: jeremie.id)
videoSetup = VideoClip.create(id:5, title:'Setup', description:'Description Setup' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/02%20Project%20Setup.mp4', person_id: paul.id)
videoStrategy = VideoClip.create(id:6, title:'Strategy', description:'Pattern Strategy' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/02%20Strategy%20Pattern.mp4', person_id: jeremie.id)
videoObserver = VideoClip.create(id:7, title:'Observer', description:'Pattern Observer' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/03%20Observer%20Pattern.mp4', person_id: jayro.id)
videoProxy = VideoClip.create(id:8, title:'Proxy', description:'Pattern Proxy' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/03%20Proxy%20Pattern.mp4', person_id: jayro.id)
videoIterator = VideoClip.create(id:9, title:'Iterator', description:'Pattern Iterator' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/04%20Iterator%20Pattern.mp4', person_id: jayro.id)
videoCommand = VideoClip.create(id:10, title:'Command', description:'Pattern Command' , is_available:true, date:Time.now, views:0, videoclip_from_url:'http://54.187.218.166:8080/html/videosam/05%20Command%20Pattern.mp4', person_id: yannis.id)


###########     Create Comment to a Video       ################

##COMPOSITE

Comment.create(id:1, message:'Merci beaucoup pour la video', is_available:true, date:Time.now, video_clip_id:videoComposite.id, person_id:andres.id)
Comment.create(id:2, message:'Merci pour partage', is_available:true, date:Time.now, video_clip_id:videoComposite.id, person_id:pedro.id)
Comment.create(id:3, message:'Cool Merci', is_available:true, date:Time.now, video_clip_id:videoComposite.id, person_id:jean.id)
Comment.create(id:4, message:'Merci', is_available:true, date:Time.now, video_clip_id:videoComposite.id, person_id:jeremie.id)
Comment.create(id:5, message:'Regarde ma page https://www.google.ch/', is_available:true, date:Time.now, video_clip_id:videoComposite.id, person_id:edison.id)

##INTRO
Comment.create(id:6, message:'Merci pour cette introduction', is_available:true, date:Time.now, video_clip_id:videoIntro.id, person_id:jayro.id)
Comment.create(id:7, message:'Merci pour partager la video', is_available:true, date:Time.now, video_clip_id:videoIntro.id, person_id:paul.id)
Comment.create(id:8, message:'Merci, continue à poster de videos', is_available:true, date:Time.now, video_clip_id:videoIntro.id, person_id:alexis.id)
Comment.create(id:9, message:'Sympas', is_available:true, date:Time.now, video_clip_id:videoIntro.id, person_id:alex.id)

##TEMPLATEMETHOD
Comment.create(id:10, message:'Rajoute plus de video stp', is_available:true, date:Time.now, video_clip_id:videoTemplateMethod.id, person_id:yannis.id)
Comment.create(id:11, message:'More', is_available:true, date:Time.now, video_clip_id:videoTemplateMethod.id, person_id:jayro.id)
Comment.create(id:12, message:'Sympas la vidéo', is_available:true, date:Time.now, video_clip_id:videoTemplateMethod.id, person_id:edison.id)
Comment.create(id:13, message:'J\'aime', is_available:true, date:Time.now, video_clip_id:videoTemplateMethod.id, person_id:oscar.id)
Comment.create(id:14, message:'Merci mon ami', is_available:true, date:Time.now, video_clip_id:videoTemplateMethod.id, person_id:jean.id)

##DECORATOR
Comment.create(id:15, message:'Merci beaucoup pour la video', is_available:true, date:Time.now, video_clip_id:videoDecorator.id, person_id:oscar.id)
Comment.create(id:16, message:'Merci', is_available:true, date:Time.now, video_clip_id:videoDecorator.id, person_id:yannis.id)
Comment.create(id:17, message:'Cool cool cool!', is_available:true, date:Time.now, video_clip_id:videoDecorator.id, person_id:jayro.id)

##SETUP
Comment.create(id:18, message:'Je veux plus de videos!', is_available:true, date:Time.now, video_clip_id:videoSetup.id,person_id:jayro.id)
Comment.create(id:19, message:'Merci beaucoup, un bon example!! Merci', is_available:true, date:Time.now, video_clip_id:videoSetup.id, person_id:jeremie.id)
Comment.create(id:20, message:'Merci pour tes videos!', is_available:true, date:Time.now, video_clip_id:videoSetup.id, person_id:yannis.id)

##STRATEGY
Comment.create(id:21, message:'Cool cool cool!!!', is_available:true, date:Time.now, video_clip_id:videoStrategy.id, person_id:paul.id)
Comment.create(id:22, message:'More', is_available:true, date:Time.now, video_clip_id:videoStrategy.id, person_id:edison.id)
Comment.create(id:23, message:'Merci pour tes videos!', is_available:true, date:Time.now, video_clip_id:videoStrategy.id, person_id:jean.id)
Comment.create(id:24, message:'J\'aime', is_available:true, date:Time.now, video_clip_id:videoStrategy.id, person_id:jacques.id)
Comment.create(id:25, message:'Je veux plus de videos!', is_available:true, date:Time.now, video_clip_id:videoStrategy.id, person_id:christian.id)

##OBSERVER
Comment.create(id:26, message:'Merci!', is_available:true, date:Time.now, video_clip_id:videoObserver.id, person_id:christian.id)
Comment.create(id:27, message:'Merci beaucoup!!!!!', is_available:true, date:Time.now, video_clip_id:videoObserver.id, person_id:oscar.id)
Comment.create(id:28, message:'Merci pour tes videos!', is_available:true, date:Time.now, video_clip_id:videoObserver.id, person_id:yannis.id)
Comment.create(id:29, message:'Thanks!!', is_available:true, date:Time.now, video_clip_id:videoObserver.id, person_id:pedro.id)

##PROXY
Comment.create(id:30, message:'More please!', is_available:true, date:Time.now, video_clip_id:videoProxy.id, person_id:alex.id)
Comment.create(id:31, message:'Thanks you!!!!', is_available:true, date:Time.now, video_clip_id:videoProxy.id, person_id:alexis.id)
Comment.create(id:32, message:'Sympas!', is_available:true, date:Time.now, video_clip_id:videoProxy.id, person_id:edison.id)

##ITERATOR
Comment.create(id:33, message:'Merci!!', is_available:true, date:Time.now, video_clip_id:videoIterator.id, person_id:paul.id)
Comment.create(id:34, message:'Sans commentaires :P !!!!', is_available:true, date:Time.now, video_clip_id:videoIterator.id, person_id:yannis.id)
Comment.create(id:35, message:':) !', is_available:true, date:Time.now, video_clip_id:videoIterator.id, person_id:jeremie.id)


###########     Create Thumbnail to a Video     ################

##COMPOSITE
Thumbnail.create({
                :id => 1,
                :image => File.open(File.join(Rails.root, 'public', 'system','photos', '1', 'original', 'city.jpg')),
                :video_clip_id => videoComposite.id,
                :main_thumbnail => true
            })

Thumbnail.create({
                 :id => 2,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '2', 'original', 'irlande.jpg')),
                 :video_clip_id => videoComposite.id,
                 :main_thumbnail => false
             })

Thumbnail.create({
                 :id => 3,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '3', 'original', 'market.jpg')),
                 :video_clip_id => videoComposite.id,
                 :main_thumbnail => false
             })

##INTRO
Thumbnail.create({
                 :id => 4,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '4', 'original', 'backimage.jpg')),
                 :video_clip_id => videoIntro.id,
                 :main_thumbnail => false
             })

Thumbnail.create({
                 :id => 5,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '5', 'original', 'canoe.jpg')),
                 :video_clip_id => videoIntro.id,
                 :main_thumbnail => true
             })

##TEMPLATEMETHOD
Thumbnail.create({
                 :id => 6,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '6', 'original', 'circle.jpg')),
                 :video_clip_id => videoTemplateMethod.id,
                 :main_thumbnail => true
             })

Thumbnail.create({
                 :id => 7,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '7', 'original', 'computer.jpg')),
                 :video_clip_id => videoTemplateMethod.id,
                 :main_thumbnail => false
             })

##DECORATOR
Thumbnail.create({
                  :id => 8,
                  :image => File.open(File.join(Rails.root, 'public', 'system','photos', '8', 'original', 'concert.jpg')),
                  :video_clip_id => videoDecorator.id,
                  :main_thumbnail => true
              })

Thumbnail.create({
                  :id => 9,
                  :image => File.open(File.join(Rails.root, 'public', 'system','photos', '9', 'original', 'construction.jpg')),
                  :video_clip_id => videoDecorator.id,
                  :main_thumbnail => false
              })

##SETUP
Thumbnail.create({
                 :id => 10,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '10', 'original', 'desing.jpg')),
                 :video_clip_id => videoSetup.id,
                 :main_thumbnail => false
             })

Thumbnail.create({
                 :id => 11,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '11', 'original', 'exposition.jpg')),
                 :video_clip_id => videoSetup.id,
                 :main_thumbnail => false
             })

Thumbnail.create({
                 :id => 12,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '12', 'original', 'flowerimg.jpg')),
                 :video_clip_id => videoSetup.id,
                 :main_thumbnail => true
             })

##STRATEGY
Thumbnail.create({
                   :id => 13,
                   :image => File.open(File.join(Rails.root, 'public', 'system','photos', '13', 'original', 'human.jpg')),
                   :video_clip_id => videoStrategy.id,
                   :main_thumbnail => true
               })

Thumbnail.create({
                 :id => 14,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '14', 'original', 'iphone.png')),
                 :video_clip_id => videoStrategy.id,
                 :main_thumbnail => false
             })

##OBSERVER
Thumbnail.create({
                  :id => 15,
                  :image => File.open(File.join(Rails.root, 'public', 'system','photos', '15', 'original', 'map.jpg')),
                  :video_clip_id => videoObserver.id,
                  :main_thumbnail => false
              })

Thumbnail.create({
                  :id => 16,
                  :image => File.open(File.join(Rails.root, 'public', 'system','photos', '16', 'original', 'mountains.jpg')),
                  :video_clip_id => videoObserver.id,
                  :main_thumbnail => true
              })

##PROXY
Thumbnail.create({
                  :id => 17,
                  :image => File.open(File.join(Rails.root, 'public', 'system','photos', '17', 'original', 'opensource.jpg')),
                  :video_clip_id => videoProxy.id,
                  :main_thumbnail => true
              })

Thumbnail.create({
                  :id => 18,
                  :image => File.open(File.join(Rails.root, 'public', 'system','photos', '18', 'original', 'web.jpg')),
                  :video_clip_id => videoProxy.id,
                  :main_thumbnail => false
              })

##ITERATOR
Thumbnail.create({
                 :id => 19,
                 :image => File.open(File.join(Rails.root, 'public', 'system','photos', '19', 'original', 'microsoft.png')),
                 :video_clip_id => videoIterator.id,
                 :main_thumbnail => true
             })

##COMMAND
Thumbnail.create({
                  :id => 20,
                  :image => File.open(File.join(Rails.root, 'public', 'system','photos', '20', 'original', 'softwarewar.png')),
                  :video_clip_id => videoCommand.id,
                  :main_thumbnail => true
              })
