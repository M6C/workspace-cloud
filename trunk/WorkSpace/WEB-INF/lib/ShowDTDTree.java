import com.wutka.dtd.*;
import java.io.*;
import java.util.*;

public class ShowDTDTree
{
	public static void main(String[] args)
	{
		try
		{
			DTDParser parser = new DTDParser(new File(args[0]), false);

            if (args.length < 1)
            {
                System.out.println("Please supply a DTD name and optionally a root element");
                System.exit(0);
            }

            boolean guessRoot = true;
            String rootName = null;

            if (args.length > 1)
            {
                rootName = args[1];
                guessRoot = false;
            }

			DTD dtd = parser.parse(guessRoot);

            DTDElement rootElement = null;

            if (rootName != null)
            {
                rootElement = (DTDElement) dtd.elements.get(rootName);
            }
            else
            {
                rootElement = dtd.rootElement;
            }

			if (rootElement == null)
			{
                String[] roots = getRootList(dtd);

                if (roots.length == 0)
                {
				    System.out.println("Can't guess the root element");
                }
                else
                {
                    System.out.println("The possible roots are:");
                    for (int i=0; i < roots.length; i++)
                    {
                        System.out.println(roots[i]);
                    }
                    System.out.println();
                    System.out.println("You may supply a root name as the second argument to this command.");
                }
				System.exit(0);
			}

			printElementTree(dtd, rootElement, rootElement.name,
                new Stack());
		}
		catch (Exception exc)
		{
			exc.printStackTrace();
		}
	}

	protected static void printElementTree(DTD dtd, DTDElement element,
		String pad, Stack stack)
	{
        if (stack.contains(element.name))
        {
			System.out.println(pad+" -- "+element.name);
            return;
        }

        stack.push(element.name);

		if (!(element.content instanceof DTDContainer)) 
		{
			System.out.println(pad+" -- "+element.name);
		}
		else
		{
			DTDItem[] items = ((DTDContainer) element.content).getItems();

			Vector elems = new Vector();

			for (int i=0; i < items.length; i++)
			{
                if (items[i] instanceof DTDContainer)
                {
                    expandContainer((DTDContainer) items[i], elems, dtd);
                    continue;
                }
                else if (!(items[i] instanceof DTDName))
                {
                    continue;
                }

				DTDElement currElem = (DTDElement) dtd.elements.get(
					((DTDName) items[i]).value);

				if (currElem == null) continue;

				elems.addElement(currElem);
			}

			if (elems.size() == 0)
			{
				System.out.println(pad);
//                stack.pop();
				return;
			}

			String pipePad = makePipePad(pad);

			for (int i=0; i < elems.size(); i++)
			{
				DTDElement currElem = (DTDElement) elems.elementAt(i);

				if (i == 0)
				{
					printElementTree(dtd, currElem, pad+" -- "+currElem.name, stack);
				}
				else if (i < elems.size()-1)
				{
					printElementTree(dtd, currElem, pipePad+" |- "+currElem.name, stack);
				}
				else
				{
					printElementTree(dtd, currElem, pipePad+" +- "+currElem.name, stack);
				}
			}
		}
//        stack.pop();
	}

    protected static void expandContainer(DTDContainer container,
        Vector v, DTD dtd)
    {
        DTDItem[] items = container.getItems();

        for (int i=0; i < items.length; i++)
        {
            if (items[i] instanceof DTDContainer)
            {
                expandContainer((DTDContainer) items[i], v, dtd);
                continue;
            }
            else if (!(items[i] instanceof DTDName))
            {
                continue;
            }

			DTDElement currElem = (DTDElement) dtd.elements.get(
				((DTDName) items[i]).value);

			if (currElem == null) continue;

			v.addElement(currElem);
        }
    }

	protected static String makePipePad(String pad)
	{
		StringBuffer buffer = new StringBuffer(pad.length());

		int len = pad.length();

		for (int i=0; i < len; i++)
		{
			char ch = pad.charAt(i);
			
			if (ch == '|')
			{
				buffer.append('|');
			}
			else if (ch == '-')
			{
				if ((i > 0) && (i < len-2) && (pad.charAt(i-1) == ' ') &&
					(pad.charAt(i+1) == '-') && (pad.charAt(i+2) == ' '))
				{
					buffer.append('|');
				}
				else
				{
					buffer.append(' ');
				}
			}
			else
			{
				buffer.append(' ');
			}
		}

		return buffer.toString();
	}

    protected static String[] getRootList(DTD dtd)
    {
        Hashtable roots = new Hashtable();

        Enumeration e = dtd.elements.elements();

        while (e.hasMoreElements())
        {
            DTDElement element = (DTDElement) e.nextElement();
            roots.put(element.name, element);
        }

        e = dtd.elements.elements();
        while (e.hasMoreElements())
        {
            DTDElement element = (DTDElement) e.nextElement();
            if (!(element.content instanceof DTDContainer)) continue;

            Enumeration items = ((DTDContainer) element.content).
                getItemsVec().  elements();

            while (items.hasMoreElements())
            {
                removeElements(roots, dtd, (DTDItem) items.nextElement());
            }
        }

        Vector v = new Vector();
        e = roots.keys();

        while (e.hasMoreElements())
        {
            v.addElement(e.nextElement());
        }
        String[] rootList = new String[v.size()];
        v.copyInto(rootList);

        return rootList;
    }

    protected static void removeElements(Hashtable h, DTD dtd, DTDItem item)
    {
        if (item instanceof DTDName)
        {
            h.remove(((DTDName) item).value);
        }
        else if (item instanceof DTDContainer)
        {
            Enumeration e = ((DTDContainer) item).getItemsVec().elements();

            while (e.hasMoreElements())
            {
                removeElements(h, dtd, (DTDItem) e.nextElement());
            }
        }
    }

}
