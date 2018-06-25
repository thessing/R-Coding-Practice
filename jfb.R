
library("dplyr", lib.loc="~/R/win-library/3.4")
library("ggplot2", lib.loc="~/R/win-library/3.4")
library("stringr", lib.loc="~/R/win-library/3.4")
library("tidyr", lib.loc="~/R/win-library/3.4")
library("ggplot2", lib.loc="~/R/win-library/3.4")


ncsa <- read.csv("BradleyCombineResults-ALL.csv")
#
# Standardize Height into numeric/inches
#
ncsa$Hgt <- sapply(strsplit(as.character(ncsa$Height),"'|\""), 
                   function(x){12*as.numeric(x[1]) + as.numeric(x[2])})
#
# Clean States to be only two-letter abbreviations
#
ncsa$State[!is.na(match(ncsa$State, state.name))] <- 
  state.abb[match(ncsa$State[!is.na(match(ncsa$State, state.name))], state.name)]
#
# All non-states except "ON"=Ontario set to NA
#
ncsa$State[is.na(match(ncsa$State, state.abb)) & is.na(match(ncsa$State, "ON"))] <- NA
#
#
#
h1 <- aggregate(ncsa$Hgt[!is.na(ncsa$Hgt)],   by = list(ncsa$Position[!is.na(ncsa$Hgt)], ncsa$Grad.Year[!is.na(ncsa$Hgt)]), mean)
h2 <- aggregate(ncsa$Hgt[!is.na(ncsa$Hgt)]>0, by = list(ncsa$Position[!is.na(ncsa$Hgt)], ncsa$Grad.Year[!is.na(ncsa$Hgt)]), sum)
h3 <- merge(h1,h2,by=c("Group.1", "Group.2"))

gh <- ggplot(data=h3, mapping = aes(x=h3$Group.1, y=h3$x.x, color=as.factor(h3$Group.2), size=h3$x.y)) +
  labs(x = "Position",
       y = "Average Height (in)",
       color = "Graduation Year",
       size = "Number of Participants") +
  geom_point() +
  geom_hline(yintercept = ncsa$Hgt[grep("Hessing", ncsa$Last.Name)], color = "red") +
  geom_hline(yintercept = 72.25, color = "yellow") +
  geom_hline(yintercept = 73, color = "green")

w1 <- aggregate(ncsa$Weight[!is.na(ncsa$Weight)],   by = list(ncsa$Position[!is.na(ncsa$Weight)], ncsa$Grad.Year[!is.na(ncsa$Weight)]), mean)
w2 <- aggregate(ncsa$Hgt[   !is.na(ncsa$Weight)]>0, by = list(ncsa$Position[!is.na(ncsa$Weight)], ncsa$Grad.Year[!is.na(ncsa$Weight)]), sum)
w3 <- merge(w1,w2,by=c("Group.1", "Group.2"))

gw <- ggplot(data=w3, mapping = aes(x=w3$Group.1, y=w3$x.x, color=as.factor(w3$Group.2), size=w3$x.y)) +
  labs(x = "Position",
       y = "Average Weight (lbs)",
       color = "Graduation Year",
       size = "Number of Participants") +
  geom_point() +
  geom_hline(yintercept = ncsa$Weight[grep("Hessing", ncsa$Last.Name)], color = "red")

x41 <- aggregate(ncsa$X40[!is.na(ncsa$X40)],   by = list(ncsa$Position[!is.na(ncsa$X40)], ncsa$Grad.Year[!is.na(ncsa$X40)]), mean)
x42 <- aggregate(ncsa$Hgt[!is.na(ncsa$X40)]>0, by = list(ncsa$Position[!is.na(ncsa$X40)], ncsa$Grad.Year[!is.na(ncsa$X40)]), sum)
x43 <- merge(x41,x42,by=c("Group.1", "Group.2"))

gx4 <- ggplot(data=x43, mapping = aes(x=x43$Group.1, y=x43$x.x, color=as.factor(x43$Group.2), size=x43$x.y)) +
  labs(x = "Position",
       y = "Average 40 yd Dash Time (sec)",
       color = "Graduation Year",
       size = "Number of Participants") +
  geom_point() +
  geom_hline(yintercept = ncsa$X40[grep("Hessing", ncsa$Last.Name)], color = "red")

xS1 <- aggregate(ncsa$SH[ !is.na(ncsa$SH)],   by = list(ncsa$Position[!is.na(ncsa$SH)], ncsa$Grad.Year[!is.na(ncsa$SH)]), mean)
xS2 <- aggregate(ncsa$Hgt[!is.na(ncsa$SH)]>0, by = list(ncsa$Position[!is.na(ncsa$SH)], ncsa$Grad.Year[!is.na(ncsa$SH)]), sum)
xS3 <- merge(xS1,xS2,by=c("Group.1", "Group.2"))

gS4 <- ggplot(data=xS3, mapping = aes(x=xS3$Group.1, y=xS3$x.x, color=as.factor(xS3$Group.2), size=xS3$x.y)) +
  labs(x = "Position",
       y = "Average Shuttle Time (sec)",
       color = "Graduation Year",
       size = "Number of Participants") +
  geom_point() +
  geom_hline(yintercept = ncsa$SH[grep("Hessing", ncsa$Last.Name)], color = "red")

xC1 <- aggregate(ncsa$X3C[!is.na(ncsa$X3C)],   by = list(ncsa$Position[!is.na(ncsa$X3C)], ncsa$Grad.Year[!is.na(ncsa$X3C)]), mean)
xC2 <- aggregate(ncsa$Hgt[!is.na(ncsa$X3C)]>0, by = list(ncsa$Position[!is.na(ncsa$X3C)], ncsa$Grad.Year[!is.na(ncsa$X3C)]), sum)
xC3 <- merge(xC1,xC2,by=c("Group.1", "Group.2"))

gC4 <- ggplot(data=xC3, mapping = aes(x=xC3$Group.1, y=xC3$x.x, color=as.factor(xC3$Group.2), size=xC3$x.y)) +
  labs(x = "Position",
       y = "Average 3-Cone Time (sec)",
       color = "Graduation Year",
       size = "Number of Participants") +
  geom_point() +
  geom_hline(yintercept = ncsa$X3C[grep("Hessing", ncsa$Last.Name)], color = "red")

xB1 <- aggregate(ncsa$BJ[ !is.na(ncsa$BJ)],   by = list(ncsa$Position[!is.na(ncsa$BJ)], ncsa$Grad.Year[!is.na(ncsa$BJ)]), mean)
xB2 <- aggregate(ncsa$Hgt[!is.na(ncsa$BJ)]>0, by = list(ncsa$Position[!is.na(ncsa$BJ)], ncsa$Grad.Year[!is.na(ncsa$BJ)]), sum)
xB3 <- merge(xB1,xB2,by=c("Group.1", "Group.2"))

gB4 <- ggplot(data=xB3, mapping = aes(x=xB3$Group.1, y=xB3$x.x, color=as.factor(xB3$Group.2), size=xB3$x.y)) +
  labs(x = "Position",
       y = "Average Broad Jump (in)",
       color = "Graduation Year",
       size = "Number of Participants") +
  geom_point() +
  geom_hline(yintercept = ncsa$BJ[grep("Hessing", ncsa$Last.Name)], color = "red")

xV1 <- aggregate(ncsa$VJ[ !is.na(ncsa$VJ)],   by = list(ncsa$Position[!is.na(ncsa$VJ)], ncsa$Grad.Year[!is.na(ncsa$VJ)]), mean)
xV2 <- aggregate(ncsa$Hgt[!is.na(ncsa$VJ)]>0, by = list(ncsa$Position[!is.na(ncsa$VJ)], ncsa$Grad.Year[!is.na(ncsa$VJ)]), sum)
xV3 <- merge(xV1,xV2,by=c("Group.1", "Group.2"))

gV4 <- ggplot(data=xV3, mapping = aes(x=xV3$Group.1, y=xV3$x.x, color=as.factor(xV3$Group.2), size=xV3$x.y)) +
  labs(x = "Position",
       y = "Average Vertical Jump (in)",
       color = "Graduation Year",
       size = "Number of Participants") +
  geom_point() +
  geom_hline(yintercept = ncsa$VJ[grep("Hessing", ncsa$Last.Name)], color = "red")

pdf("file.pdf",width=6,height=4,paper='special')
gh
gw
gx4
gS4
gC4
gB4
gV4
dev.off()

n <- ncsa[ncsa$Position %in% c("C","DE","DT","OG","OT","TE","FB","MLB","OLB","RB"),] 
gh <- ggplot(data=n[!is.na(n$Hgt),], mapping = aes(x=n$Position[ !is.na(n$Hgt)], 
                                                   y=n$Hgt[      !is.na(n$Hgt)], 
                                     color=as.factor(n$Grad.Year[!is.na(n$Hgt)]) ) ) +
  labs(x = "Position",
       y = "Height (in)",
       color = "Graduation Year") +
  geom_boxplot() +
  geom_hline(yintercept = n$Hgt[grep("Hessing", n$Last.Name)], color = "red") +
  geom_hline(yintercept = 72.25, color = "yellow") +
  geom_hline(yintercept = 73, color = "green")

gw <- ggplot(data=n[!is.na(n$Weight),], mapping = aes(x=n$Position[ !is.na(n$Weight)], 
                                                      y=n$Weight[   !is.na(n$Weight)], 
                                        color=as.factor(n$Grad.Year[!is.na(n$Weight)]) ) ) +
  labs(x = "Position",
       y = "Weight (lbs)",
       color = "Graduation Year") +
  geom_boxplot() +
  geom_hline(yintercept = n$Weight[grep("Hessing", n$Last.Name)], color = "red")

gx4 <- ggplot(data=n[!is.na(n$X40),], mapping = aes(x=n$Position[ !is.na(n$X40)], 
                                                    y=n$X40[      !is.na(n$X40)], 
                                      color=as.factor(n$Grad.Year[!is.na(n$X40)]) ) ) +
  labs(x = "Position",
       y = "40 yd Dash Time (s)",
       color = "Graduation Year") +
  geom_boxplot() +
  geom_hline(yintercept = n$X40[grep("Hessing", n$Last.Name)], color = "red")

gs4 <- ggplot(data=n[!is.na(n$SH),], mapping = aes(x=n$Position[ !is.na(n$SH)], 
                                                   y=n$SH[       !is.na(n$SH)], 
                                     color=as.factor(n$Grad.Year[!is.na(n$SH)]) ) ) +
  labs(x = "Position",
       y = "Shuttle Time (s)",
       color = "Graduation Year") +
  geom_boxplot() +
  geom_hline(yintercept = n$SH[grep("Hessing", n$Last.Name)], color = "red")

gc4 <- ggplot(data=n[!is.na(n$X3C),], mapping = aes(x=n$Position[ !is.na(n$X3C)], 
                                                    y=n$X3C[      !is.na(n$X3C)], 
                                      color=as.factor(n$Grad.Year[!is.na(n$X3C)]) ) ) +
  labs(x = "Position",
       y = "3 Cone Time (s)",
       color = "Graduation Year") +
  geom_boxplot() +
  geom_hline(yintercept = n$X3C[grep("Hessing", n$Last.Name)], color = "red")

gb4 <- ggplot(data=n[!is.na(n$BJ),], mapping = aes(x=n$Position[ !is.na(n$BJ)], 
                                                   y=n$BJ[       !is.na(n$BJ)], 
                                     color=as.factor(n$Grad.Year[!is.na(n$BJ)]) ) ) +
  labs(x = "Position",
       y = "Broad Jump (in)",
       color = "Graduation Year") +
  geom_boxplot() +
  geom_hline(yintercept = n$BJ[grep("Hessing", n$Last.Name)], color = "red")

gv4 <- ggplot(data=n[!is.na(n$VJ),], mapping = aes(x=n$Position[ !is.na(n$VJ)], 
                                                   y=n$VJ[       !is.na(n$VJ)], 
                                     color=as.factor(n$Grad.Year[!is.na(n$VJ)]) ) ) +
  labs(x = "Position",
       y = "Vertical Jump (in)",
       color = "Graduation Year") +
  geom_boxplot() +
  geom_hline(yintercept = n$VJ[grep("Hessing", n$Last.Name)], color = "red")

#
# Open 480x480 png file
#
png(filename = "fb-hgt.png", width = 480, height = 480)
gh
dev.off()
png(filename = "fb-wgt.png", width = 480, height = 480)
gw
dev.off()
png(filename = "fb-40.png", width = 480, height = 480)
gx4
dev.off()
png(filename = "fb-sh.png", width = 480, height = 480)
gs4
dev.off()
png(filename = "fb-3c.png", width = 480, height = 480)
gc4
dev.off()
png(filename = "fb-bj.png", width = 480, height = 480)
gb4
dev.off()
png(filename = "fb-vj.png", width = 480, height = 480)
gv4
dev.off()



