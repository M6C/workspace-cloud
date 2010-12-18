<%@ page import="java.io.*,java.nio.*, java.nio.channels.*"%>

<%
  FileChannel rbc = null;
  WritableByteChannel wbc = null;
  
  try {
      String filename = (String) request.getAttribute("path");
      File file = new File(filename);

      rbc = new FileInputStream(file).getChannel();
      rbc.position(0);
      wbc = Channels.newChannel(response.getOutputStream());
      response.setContentType(getServletContext().getMimeType(filename));
      response.setHeader("Content-Length", String.valueOf(file.length()));
  
      ByteBuffer bb = ByteBuffer.allocateDirect(11680);
  
        while (rbc.read(bb) != -1) {
            bb.flip();
            wbc.write(bb);
            bb.clear();
        }
  
      wbc.close();
      rbc.close();
  }
  catch(Exception exp) {
      exp.printStackTrace();

      if (wbc != null)
        wbc.close();

      if (rbc != null)
        rbc.close();
  }
%>
