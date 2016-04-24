package workspace.service;

//http://www.developpez.net/forums/showthread.php?t=20217
//http://java.developpez.com/faq/java/?page=graphique_general_images#GRAPHIQUE_IMAGE_capture_ecran

import java.awt.*;

import java.awt.event.*;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
import java.util.Calendar;

public class SrvAdminPrintScreen {
        
    private 
        int tempattente;
        String nomfichier;
    
    public String getNomFichier(){
        return nomfichier; 
    }    
        
    public SrvAdminPrintScreen(){
        tempattente = 1;
        Calendar calendar = Calendar.getInstance();
        String YY = (calendar.get(Calendar.YEAR)+"").substring(2);
        String MM = ((calendar.get(Calendar.MONTH)+1)+"");
        String DD = (calendar.get(Calendar.DAY_OF_MONTH)+"");
        String HH = (calendar.get(Calendar.HOUR)+"");
        String MI = (calendar.get(Calendar.MINUTE)+"");
        
        int AMint = (calendar.get(Calendar.AM_PM));
        String AMStr;
        if (AMint == 0) {AMStr = "AM"; } else {AMStr = "PM"; }

        if (MM.length() == 1) { MM = "0"+MM; }
        if (DD.length() == 1) { DD = "0"+DD; }
        if (HH.length() == 1) { HH = "0"+HH; }
        if (MI.length() == 1) { MI = "0"+MI; }

        nomfichier = YY+"-"+MM+"-"+DD+"_"+HH+"-"+MI+"-"+AMStr+".png";
    }
    
    public void takeSnapShot()throws AWTException{
        Toolkit toolkit = Toolkit.getDefaultToolkit();
        Dimension screenSize = toolkit.getScreenSize();
        Rectangle screenRect = new Rectangle(screenSize);
        Robot robot = new Robot();
        BufferedImage image =    robot.createScreenCapture(screenRect);
        
        try {
            ImageIO.write(image, "png", new File(getNomFichier()));
        } catch (IOException ioe) {
            System.out.println(ioe.toString());
        }
    }
}