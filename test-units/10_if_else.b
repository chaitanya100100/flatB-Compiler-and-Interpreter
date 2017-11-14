declblock{
    int hour, jo, ar[65], sdf, df[654];
    int hour, jo, ar[65], sdf, df[654];
}

codeblock{

    print "Enter current hour";
    hour = 20;

    if hour > 0 {
        if hour < 6 {
            print "Good night";
        }
        else {
            if hour < 12 {
                print "Good morning";
            }
            else {
                if hour < 16 {
                    print "Good afternoon";
                }
                else {
                    if hour < 20 {
                        print "Good evening";
                    }
                    else {
                        print "Good night sweet dreams";
                    }
                }
            }
        }
    }
    else {
        print "wrong input", hour, "!";
    }
}
