// controller.dart
import 'model.dart';

class UserController {
  List<ProfileInfo> list = [
    ProfileInfo(title: 'information', content: 'nom:hiba\nprénom:chaouali\nadresse:Jendouba-Bousalem 8170'),
    ProfileInfo(title: 'education', content: 'Institut Supérieur des Études Technologiques de Jendouba\n2ème année en développement de systèmes informatiques\n2022 - En cours\nBaccalauréat en Sciences Techniques\nAnnée d\'obtention : 2022'),
    ProfileInfo(title: 'compétence informatique', content: 'Langages de programmation: Python, JavaScript, Java, C#, PHP, HTML/CSS\nFrameworks: Angular\nBase de données: MySQL\nEnvironnements de développement: VS Code, Visual Studio\nSystèmes d\'exploitation: Windows, Linux\nModélisation: UML\nBureautique: Microsoft Office Suite (Word, Excel, PowerPoint)'),
    ProfileInfo(title: 'certifications', content: 'Créez Votre Application Mobile Sans Coder - Enactus limitl’ESS FSEG Jendouba - 08 mars 2022\nIntégration à la Vie Associative, Rédaction des Projets Culturels, Entrepreneuriat - Association nationale des Clubs Universitaires - 24-25-26 Août 2022'),
    ProfileInfo(title: 'projects', content: 'Interface Météorologique - Description: Conception et mise en œuvre d\'une interface météorologique interactive - Technologies utilisées: HTML, CSS, JavaScript, PHP - Date: novembre 2023\nUn site internet commercial - Description: Développement complet d\'un site web de commerce - Technologies utilisées: HTML, CSS, JavaScript - Date: octobre 2023'),
    ProfileInfo(title: 'langue', content: 'Arabe\nfrançais\nanglais'),
  ];
}


class ProfileInfo {
  final String title;
  final String content;

  ProfileInfo({required this.title, required this.content});
}





