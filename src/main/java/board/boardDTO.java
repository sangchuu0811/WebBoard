package board;

public class boardDTO {

    private int num;
    private String writer;
    private String title;
    private String content;
    private String regtime;
    private int hits;

    // constructor()
    public boardDTO() {};

    public boardDTO(String writer, String title, String content, String regtime, int hits) {
        this.writer = writer;
        this.title = title;
        this.content = content;
        this.regtime = regtime;
        this.hits = hits;
    }

    // getter / setter
    public int getNum() {
        return num;
    }
    public void setNum(int num) {
        this.num = num;
    }

    public String getWriter() {
        return writer;
    }
    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    public String getRegtime() {
        return regtime;
    }
    public void setRegtime(String regtime) {
        this.regtime = regtime;
    }

    public int getHits() {
        return hits;
    }
    public void setHits(int hits) {
        this.hits = hits;
    }
}